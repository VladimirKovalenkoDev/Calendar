//
//  EventsViewModelMock.swift
//  CalendarTests
//
//  Created by vladimir_kovalenko on 5/25/22.
//

import Foundation
import CoreData
@testable import Calendar

enum EventsViewModelMock {
 
    static func getEventViewModel() -> EventViewModel {
        EventViewModel(event: Events(context: CoreManager.shared.container.viewContext))
    }
}
