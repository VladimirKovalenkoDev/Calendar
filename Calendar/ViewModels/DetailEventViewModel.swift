//
//  DetailEventViewModel.swift
//  Calendar
//
//  Created by vladimir_kovalenko on 5/23/22.
//

import Foundation
import CoreData
import SwiftUI

final class DetailEventViewModel: ObservableObject, Identifiable {
    
    @Published var eventName: String
    @Published var eventDate: String
    @Published var startDate: String
    @Published var endDate: String
    
    private (set) var context: NSManagedObjectContext
    private var selectedEvent: EventViewModel
    private unowned var coordinator: DetailEventCoordinator

    init(
        context: NSManagedObjectContext,
        selectedEvent: EventViewModel,
        coordinator: DetailEventCoordinator
    ) {
        self.context = context
        self.selectedEvent = selectedEvent
        self.coordinator = coordinator
        self.eventName = selectedEvent.eventName
        self.eventDate = selectedEvent.startTime.dateWithDayOfTheWeek()
        self.startDate = selectedEvent.startTime.timeIn24HourFormat()
        self.endDate = selectedEvent.endTime.timeIn24HourFormat()
    }
    
    func delete() {
        do {
            try selectedEvent.event.delete()
        } catch {
            print("Error in deleting \(error)")
        }
    }
}
