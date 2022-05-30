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
    @Published var editEventViewModel: EditEventViewModel?
    
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
    
    func openEvent(_ selectedEvent: EventViewModel) {
        self.editEventViewModel = .init(
            context: context,
            selectedEvent: selectedEvent
        )
//        self.newEventViewModel = .init(
//            context: context,
//            chosenDate: chosenDate,
//            eventName: eventName
//        )
    }
}
