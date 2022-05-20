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
            context: context,
            chosenDate: date,
            coordinator: self,
            builder: builder,
            mapper: mapper
        )
    }
    
    func openNewEvent(_ date: Date) {
        self.newEventViewModel = .init(
            context: context,
            coordinator: parent,
            chosenDate: date
        )
    }
}
