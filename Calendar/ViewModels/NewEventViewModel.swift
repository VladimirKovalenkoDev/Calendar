//
//  NewEventViewModel.swift
//  Calendar
//
//  Created by vladimir_kovalenko on 5/12/22.
//

import Foundation
import CoreData

final class NewEventViewModel: ObservableObject {
    @Published var eventName: String = String()
    @Published var eventDate: Date = .init()//???
    @Published var startTime: Date = .init()
    @Published var endTime: Date = .init()
    
    
    private (set) var context: NSManagedObjectContext
    private var currentDate: Date = .init()
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func save() {
        do {
            let event = Events(context: context)
            event.eventName = eventName
            event.startTime = startTime
            event.endTime = endTime
            try event.save()
        } catch {
            print("Saving Error: \(error)")
        }
    }
}
