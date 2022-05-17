//
//  NewEventViewModel.swift
//  Calendar
//
//  Created by vladimir_kovalenko on 5/12/22.
//

import Foundation
import CoreData
import Combine

final class NewEventViewModel: ObservableObject {
    @Published var eventName: String = String()
    @Published var eventDate: Date = .init()//???
    @Published var startTime: Date = .init()
    @Published var endTime: Date = .init()
    
    private var cancellable: Cancellable?
    private (set) var context: NSManagedObjectContext
    private var currentDate: Date = .init()
    
    init(context: NSManagedObjectContext) {
        self.context = context
        changeEndTimeValue()
    }
    
    private func changeEndTimeValue() {
        cancellable = $startTime.sink(receiveValue: { value in
            self.endTime = value
        })
    }
    
    func save() {
        do {
            let event = Events(context: context)
            event.eventName = eventName
            event.startTime = startTime
            event.endTime = endTime
            event.eventDate = startTime.onlyDateFormat()
            try event.save()
        } catch {
            print("Saving Error: \(error)")
        }
    }
}
