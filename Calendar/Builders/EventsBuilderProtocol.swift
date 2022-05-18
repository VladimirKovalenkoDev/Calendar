//
//  EventsBuilderProtocol.swift
//  Calendar
//
//  Created by vladimir_kovalenko on 5/18/22.
//

import Foundation

protocol EventsBulderProtocol {
    func getSortedEvents(events: [DrawableEventModel]) -> [[DrawableEventModel]]
}
