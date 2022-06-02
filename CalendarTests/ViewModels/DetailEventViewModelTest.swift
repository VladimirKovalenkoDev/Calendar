//
//  DetailEventViewModelTest.swift
//  CalendarTests
//
//  Created by vladimir_kovalenko on 6/1/22.
//

import XCTest
import CoreData
@testable import Calendar

class DetailEventViewModelTest: XCTestCase {
    private let context = CoreManager.shared.container.viewContext
    private let selectedEvent = EventsViewModelMock.getEventViewModel()
    
    func test_initViewModel() {
        
    }
}
