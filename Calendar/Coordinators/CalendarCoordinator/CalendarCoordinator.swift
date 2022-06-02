//
//  CalendarCoordinator.swift
//  Calendar
//
//  Created by vladimir_kovalenko on 5/18/22.
//

import SwiftUI
import CoreData

class CalendarCoordinator: ObservableObject, Identifiable {
    
    @Published var viewModel: CalendarViewModel!
    @Published var newEventViewModel: NewEventViewModel?
    @Published var scheduleCoordinator: SchedulerCoordinator?
    
    private (set) var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
        
        self.viewModel = .init(
            coordinator: self
        )
    }
    
    func open(_ date: Date) {
        self.scheduleCoordinator = .init(
            context: context,
            date: date,
            parent: self
        )
    }
    
    func openNewEvent(_ date: Date) {
        self.newEventViewModel = .init(
            context: context,
            chosenDate: date,
            eventName: ""
        )
    }
}
