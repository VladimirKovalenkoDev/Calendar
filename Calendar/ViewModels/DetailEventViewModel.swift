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
    
    @Published var eventName: String = .init()
    @Published var eventDate: String = .init()
    @Published var startDate: String = .init()
    @Published var endDate: String = .init()
    
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
        updateView()
    }
    
    func delete() {
        do {
            try selectedEvent.event.delete()
        } catch {
            print("Error in deleting \(error)")
        }
    }
    
    func updateView() {
        eventName = selectedEvent.eventName
        eventDate = selectedEvent.startTime.dateWithDayOfTheWeek()
        startDate = selectedEvent.startTime.timeIn24HourFormat()
        endDate = selectedEvent.endTime.timeIn24HourFormat()
    }
    
    func openCurrentEvent() {
        coordinator.openEvent(selectedEvent)
    }
}
