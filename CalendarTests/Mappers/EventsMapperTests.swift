//
//  EventsMapperTests.swift
//  CalendarTests
//
//  Created by vladimir_kovalenko on 5/25/22.
//

import XCTest
@testable import Calendar

class EventsMapperTests: XCTestCase {
    
    private var mapper: EventsMapperProtocol!
    private let events = EventsViewModelMock.getEventViewModel()
    
    override func setUp() {
        super.setUp()
       mapper = EventsMapper()
    }
    
    func test_getHour() {
        let hour = mapper.getHour(date: Date())
        XCTAssertNotNil(hour)
    }
    
    func test_getMinute() {
        let minute = mapper.getMinute(date: Date())
        XCTAssertNotNil(minute)
    }
    
    func test_getDrawableEvent() {
        let drawableEvents = mapper.getDrawableEvent(event: events)
        XCTAssertNotNil(drawableEvents)
    }

}
