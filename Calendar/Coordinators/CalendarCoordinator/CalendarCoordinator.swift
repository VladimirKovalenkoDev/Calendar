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
    @Published var scheduleViewModel: ScheduleViewModel?
    
    private (set) var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
        
        self.viewModel = .init(
            context: context,
            coordinator: self
        )
    }
    
    func open(_ date: Date) {
        let mapper = EventsMapper.shared
        let builder = EventsBuilder.shared
        self.scheduleViewModel = .init(
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
            coordinator: self,
            chosenDate: date
        )
    }
    
}