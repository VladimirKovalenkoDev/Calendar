//
//  EventsMapperProtocol.swift
//  Calendar
//
//  Created by vladimir_kovalenko on 5/18/22.
//

import Foundation

protocol EventsMapperProtocol {
    func getDrawableEvent(event: EventViewModel) -> DrawableEventModel
    func getHour(date: Date) -> Float
    func getMinute(date: Date) -> Float
}
