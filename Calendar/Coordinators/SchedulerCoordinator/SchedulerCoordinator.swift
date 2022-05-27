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
    
    init(
        context: NSManagedObjectContext,
        date: Date,
        parent: CalendarCoordinator,
        builder: EventsBulderProtocol,
        mapper: EventsMapperProtocol
    ) {
        self.parent = parent
        self.context = context
        self.viewModel = .init(
            chosenDate: date,
            coordinator: self,
            builder: builder,
            mapper: mapper
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
