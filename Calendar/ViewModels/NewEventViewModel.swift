//
//  NewEventViewModel.swift
//  Calendar
//
//  Created by vladimir_kovalenko on 5/12/22.
//

import Foundation
import CoreData
import Combine

final class NewEventViewModel: ObservableObject, Identifiable {
    
    @Published var eventName: String = String()
    @Published var eventDate: Date = .init()
    @Published var startTime: Date = .init()
    @Published var endTime: Date = .init()
    
    private var currentTime: Date = .init()
    private var cancellable: Cancellable?
    private (set) var context: NSManagedObjectContext
    
    init(
        context: NSManagedObjectContext,
        chosenDate: Date,
        eventName: String
    ) {
        self.context = context
        self.startTime = chosenDate
        self.eventName = eventName
        changeEndTimeValue()
        makeStartTime()
    }
        
    func save() {
        do {
            let event = Events(context: context)
            if eventName == "" {
                self.eventName = "New Event"
            }
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

extension NewEventViewModel {
    
    private func makeStartTime() {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: currentTime)
        let minute = calendar.component(.minute, from: currentTime)
        let second = calendar.component(.second, from: currentTime)
        startTime = calendar.date(
            bySettingHour: hour,
            minute: minute,
            second: second,
            of: startTime
        ) ?? Date()
    }
    
    private func changeEndTimeValue() {
        cancellable = $startTime.sink(receiveValue: { value in
            self.endTime = value.addingTimeInterval(5*60)
        })
    }
}
