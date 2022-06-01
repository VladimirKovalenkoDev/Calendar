//
//  SchedulerCoordinator.swift
//  Calendar
//
//  Created by vladimir_kovalenko on 5/19/22.
//

import Foundation
import CoreData

class SchedulerCoordinator: ObservableObject, Identifiable {
    
    @Published var viewModel: ScheduleViewModel?
    @Published var newEventViewModel: NewEventViewModel?
    @Published var detailEventCoordinator: DetailEventCoordinator?
    
    private var parent: CalendarCoordinator
    private (set) var context: NSManagedObjectContext
    let mapper: EventsMapperProtocol
    let builder: EventsBulderProtocol
    
    init(
        context: NSManagedObjectContext,
        date: Date,
        parent: CalendarCoordinator
    ) {
        self.parent = parent
        self.context = context
        self.mapper = EventsMapper.shared
        self.builder = EventsBuilder.shared
        self.viewModel = .init(
            chosenDate: date,
            coordinator: self
        )
    }
    
    func openNewEvent(_ date: Date) {
        self.newEventViewModel = .init(
            context: context,
            chosenDate: date,
            eventName: ""
        )
    }
    
    func openDetailEvent(_ selectedEvent: EventViewModel) {
        self.detailEventCoordinator = .init(
            context: context,
            selectedEvent: selectedEvent
        )
    }
}
