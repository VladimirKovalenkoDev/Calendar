//
//  EventsBuilder.swift
//  Calendar
//
//  Created by vladimir_kovalenko on 5/18/22.
//

import Foundation

final class EventsBuilder: EventsBulderProtocol {
    static let shared = EventsBuilder()
    
    func getSortedEvents(events: [DrawableEventModel]) -> [[DrawableEventModel]] {
        var data: [[DrawableEventModel]] = [[]]
        events.forEach { event in
            var index = 0
            repeat {
                if data.count <= index {
                    data.append([DrawableEventModel]())
                }
                if isIntersect(events: data[index], current: event) {
                    index += 1
                } else {
                    data[index].append(event)
                    break
                }
            } while index > 0
        }
        return data
    }
    
    private func isIntersect(events: [DrawableEventModel], current: DrawableEventModel) -> Bool {
        if events.isEmpty {
            return false
        }
        for event in events {
            if (current.start + current.duration) < event.start ||
                (event.start + event.duration) < current.start {
            } else {
                return true
            }
        }
        return false
    }
}
