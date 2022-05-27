//
//  EditEventViewModel.swift
//  Calendar
//
//  Created by vladimir_kovalenko on 5/27/22.
//

import Foundation
import CoreData

final class EditEventViewModel: ObservableObject, Identifiable {
    
    @Published var eventName: String
    @Published var startTime: Date
    @Published var endTime: Date
    
    private (set) var context: NSManagedObjectContext
    private var selectedEvent: EventViewModel
    
    init(
        context: NSManagedObjectContext,
        selectedEvent: EventViewModel
    ) {
        self.context = context
        self.selectedEvent = selectedEvent
        self.eventName = selectedEvent.eventName
        self.startTime = selectedEvent.startTime
        self.endTime = selectedEvent.endTime
    }
    
    func edit() {
        do {
            selectedEvent.event.endTime = endTime
            selectedEvent.event.startTime = startTime
            selectedEvent.event.eventName = eventName
            try selectedEvent.event.save()
        } catch {
            print("Error in editing \(error)")
        }
    }
    
}
