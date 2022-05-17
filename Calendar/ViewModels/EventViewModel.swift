//
//  EventViewModel.swift
//  Calendar
//
//  Created by vladimir_kovalenko on 5/6/22.
//

import Foundation
import CoreData

struct EventViewModel: Identifiable, Hashable {
    private var event: Events
    
    init(event: Events) {
        self.event = event
    }
    
    var id: NSManagedObjectID {
        event.objectID
    }
    
    var eventDate: String {
        event.eventDate ?? ""
    }
    
    var eventName: String {
        event.eventName ?? ""
    }
    
    var startTime: Date {
        event.startTime ?? Date()
    }
    
    var endTime: Date {
        event.endTime ?? Date()
    }
}
