//
//  CalendarViewModel.swift
//  Calendar
//
//  Created by vladimir_kovalenko on 4/18/22.
//

import Foundation
import Combine
import CoreData
import SwiftUI

final class ScheduleViewModel: NSObject, ObservableObject, Identifiable {
    
    @Published var chosenDate: Date
    @Published var isPresented: Bool = false
    @Published var currentTimeHourPosition: Float = Float()
    @Published var currentDate: Date = .init()
    @Published var drawableArrayEvents = [[DrawableEventModel]]()
    @Published var drawableEvents = [DrawableEventModel]()
    
    private var events = [EventViewModel]()
    private let builder: EventsBulderProtocol
    private let mapper: EventsMapperProtocol
    private let fetchedResultsController: NSFetchedResultsController<Events>
    private var timeSubscriber: Cancellable?
    private var timer: Timer.TimerPublisher = Timer.publish(every: 0, on: .main, in: .common)
    private unowned let coordinator: SchedulerCoordinator
    
    init(
         chosenDate: Date,
         coordinator: SchedulerCoordinator,
         builder: EventsBulderProtocol,
         mapper: EventsMapperProtocol
    ) {
        self.chosenDate = chosenDate
        self.mapper = mapper
        self.builder = builder
        self.coordinator = coordinator
        fetchedResultsController = NSFetchedResultsController(
            fetchRequest: Events.all,
            managedObjectContext: coordinator.context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        fetchedResultsController
            .fetchRequest
            .predicate = NSPredicate(format:  "%K == %@",
                                     #keyPath(Events.eventDate),
                                     chosenDate.onlyDateFormat() as CVarArg)
        super.init()
        fetchedResultsController.delegate = self
        makeTimeLinePosition()
        performFetch()
        makeDrawable(events: events)
    }
    
    func viewDisappear() {
        timeSubscriber?.cancel()
        timeSubscriber = nil
    }
    
    func isSameDate(first: Date, second: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(first, inSameDayAs: second)
    }
    
    func dismiss() {
        drawableEvents.removeAll()
        drawableArrayEvents.removeAll()
        makeDrawable(events: events)
    }
    
    func openNewEvent(_ date: Date) {
        self.coordinator.openNewEvent(date)
    }
    
    func openDetailEvent(_ selectedEvent: EventViewModel) {
        self.coordinator.openDetailEvent(selectedEvent)
    }
}

extension ScheduleViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        if let events = controller.fetchedObjects as? [Events] {
            self.events = events.map(EventViewModel.init)
        }
    }
}

// MARK: - private methods
extension ScheduleViewModel {
    private func getCurrentTimePosition(date: Date) -> Float {
        let calendar = Calendar.current
        return Float(calendar.component(.hour, from: date)) +
        Float(calendar.component(.minute, from: date)) / 60
    }
    
    private func makeTimeLinePosition() {
        currentTimeHourPosition = getCurrentTimePosition(date: currentDate)
        timeSubscriber?.cancel()
        timeSubscriber = timer.autoconnect().sink { [weak self] output in
            self?.currentDate = output
            self?.currentTimeHourPosition = self?.getCurrentTimePosition(date: output) ?? 0
        }
    }
    
    private func performFetch() {
        do {
            try fetchedResultsController.performFetch()
            guard let events = fetchedResultsController.fetchedObjects else { return }
            self.events = events.map(EventViewModel.init)
        } catch {
            print("Fetch error: \(error)")
        }
    }
    
    private func makeDrawable(events: [EventViewModel]){
        events.forEach { event in
            self.drawableEvents.append(mapper.getDrawableEvent(event: event))
        }
        self.drawableArrayEvents = builder.getSortedEvents(events: self.drawableEvents)
    }
}
