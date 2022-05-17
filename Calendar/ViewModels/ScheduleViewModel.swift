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

final class ScheduleViewModel: NSObject, ObservableObject {
    
    @Published var chosenDate: Date
    @Published var isPresented: Bool = false
    @Published var currentTimeHourPosition: Float = Float()
    @Published var currentDate: Date = .init()
    @Published var drawableEvents = [DrawableEventModel]()
    private var events = [EventViewModel]()
    private let fetchedResultsController: NSFetchedResultsController<Events>
    private (set) var context: NSManagedObjectContext
    private var timeSubscriber: Cancellable?
    private var timer: Timer.TimerPublisher = Timer.publish(every: 0, on: .main, in: .common)
   // private unowned let coordinator: CalendarCoordinator
    
    init(context: NSManagedObjectContext, chosenDate: Date)
//         ,
//         coordinator: CalendarCoordinator)
    {
        self.chosenDate = chosenDate
        self.context = context
        fetchedResultsController = NSFetchedResultsController(
            fetchRequest: Events.all,
            managedObjectContext: context,
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
      //  self.coordinator = coordinator
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
    
    func viewDidAppear() {
        makeTimeLinePosition()
        performFetch()
        makeDrawable(events: events)
        print(drawableEvents)
    }
    
    func viewDisappear() {
        timeSubscriber?.cancel()
        timeSubscriber = nil
    }
    
    private func makeTimeLinePosition() {
        currentTimeHourPosition = getCurrentTimePosition(date: currentDate)
        timeSubscriber?.cancel()
        timeSubscriber = timer.autoconnect().sink { [weak self] output in
            self?.currentDate = output
            self?.currentTimeHourPosition = self?.getCurrentTimePosition(date: output) ?? 0
        }
    }
    
    func getCurrentTimePosition(date: Date) -> Float {
        let calendar = Calendar.current
        return Float(calendar.component(.hour, from: date)) +
        Float(calendar.component(.minute, from: date)) / 60
    }
    
    func getHour(date: Date) -> Float {
        let calendar = Calendar.current
        return Float(calendar.component(.hour, from: date))
    }
    
    func getMinute(date: Date) -> Float {
        let calendar = Calendar.current
        return Float(calendar.component(.minute, from: date))
    }
    
    func getCurrentTime(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
    
    func isSameDate(first: Date, second: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(first, inSameDayAs: second)
    }
    func makeDrawable(events: [EventViewModel]){
        events.forEach { event in
            self.drawableEvents.append(getDrawableEvent(event: event))
        }
    }
    
    func getDrawableEvent(event: EventViewModel) -> DrawableEventModel {
        let name = event.eventName
        
        let start = getHour(date: event.startTime) + getMinute(date: event.startTime) / 60
        let end = getHour(date: event.endTime) + getMinute(date: event.endTime) / 60
        
        return DrawableEventModel(name: name, start: start, duration: end-start)
    }
}

extension ScheduleViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        if let events = controller.fetchedObjects as? [Events] {
            self.events = events.map(EventViewModel.init)
        }
    }
}
