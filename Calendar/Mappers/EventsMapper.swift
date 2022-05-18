//
//  EventsMapper.swift
//  Calendar
//
//  Created by vladimir_kovalenko on 5/18/22.
//

import Foundation

final class EventsMapper: EventsMapperProtocol {
    static let shared = EventsMapper()
    
    func getDrawableEvent(event: EventViewModel) -> DrawableEventModel {
        let name = event.eventName
        
        let start = getHour(date: event.startTime) + getMinute(date: event.startTime) / 60
        let end = getHour(date: event.endTime) + getMinute(date: event.endTime) / 60
        
        return DrawableEventModel(name: name, start: start, duration: end-start)
    }
    
    func getHour(date: Date) -> Float {
        let calendar = Calendar.current
        return Float(calendar.component(.hour, from: date))
    }
    
    func getMinute(date: Date) -> Float {
        let calendar = Calendar.current
        return Float(calendar.component(.minute, from: date))
    }
    
    
}
