//
//  EditEventViewModel.swift
//  Calendar
//
//  Created by vladimir_kovalenko on 5/27/22.
//

import Foundation
import CoreData
import Combine

final class EditEventViewModel: ObservableObject, Identifiable {
    
    @Published var eventName: String
    @Published var startTime: Date
    @Published var endTime: Date
    
    private (set) var context: NSManagedObjectContext
    private var selectedEvent: EventViewModel
    private var mapper: EventsMapperProtocol
    private var cancellable: Cancellable?
    private var duration: Float
    
    init(
        context: NSManagedObjectContext,
        selectedEvent: EventViewModel
    ) {
        self.context = context
        self.selectedEvent = selectedEvent
        self.eventName = selectedEvent.eventName
        self.startTime = selectedEvent.startTime
        self.endTime = selectedEvent.endTime
        self.mapper = EventsMapper.shared
        self.duration = mapper.getDrawableEvent(event: selectedEvent).duration
        endTimeCorrection()
    }
    
    func edit() {
        do {
            selectedEvent.event.eventDate = startTime.onlyDateFormat()
            selectedEvent.event.endTime = endTime
            selectedEvent.event.startTime = startTime
            selectedEvent.event.eventName = eventName
            try selectedEvent.event.save()
        } catch {
            print("Error in editing \(error)")
        }
    }
}

// MARK: - private methods
extension EditEventViewModel {
    
    private func endTimeCorrection() {
        cancellable = $startTime.combineLatest($endTime).sink(receiveValue: { [weak self] value in
            guard let self = self else { return }
            self.endTime = value.0.addingTimeInterval(Double(self.duration) * 3600)
            let start = self.mapper.getHour(date: self.startTime) + self.mapper.getMinute(date: self.startTime) / 60
            let end = self.mapper.getHour(date: value.1) + self.mapper.getMinute(date: value.1) / 60
            self.duration = end - start
        })
    }
}
