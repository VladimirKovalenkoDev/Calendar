//
//  CalendarTests.swift
//  CalendarTests
//
//  Created by vladimir_kovalenko on 4/18/22.
//

import XCTest
import CoreData
@testable import Calendar

class CalendarTests: XCTestCase {

    private let stub = CalendarCoordinatorStubs()
    private var calendarCoordinator: CalendarCoordinator!

    func test_OpenWithDate() {
        stub.open(Date())
        XCTAssertTrue(stub.openExecuted)
    }
    
    func test_OpenNewEvent() {
        stub.openNewEvent(Date())
        XCTAssertTrue(stub.openNewEventExecuted)
    }
}
