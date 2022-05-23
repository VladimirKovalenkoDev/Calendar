//
//  DetailEventCoordinator.swift
//  Calendar
//
//  Created by vladimir_kovalenko on 5/23/22.
//

import Foundation
import CoreData

class DetailEventCoordinator: ObservableObject, Identifiable {
    
    @Published var viewModel: DetailEventViewModel?
    @Published var newEventViewModel: NewEventViewModel?
    
    private (set) var context: NSManagedObjectContext
    
    init(
        context: NSManagedObjectContext,
        selectedEvent: EventViewModel
    ) {
        self.context = context
        self.viewModel = .init(
            context: context,
            selectedEvent: selectedEvent,
            coordinator: self
        )
    }
}
