//
//  EventBuilderTests.swift
//  CalendarTests
//
//  Created by vladimir_kovalenko on 5/25/22.
//

import XCTest
@testable import Calendar

class EventBuilderTests: XCTestCase {
    private var builder: EventsBulderProtocol!
    private let drawableEventsMock = DrawableEventsModelMock.obtainDrawableEvents()
    private let sortedEvents = DrawableEventsModelMock.obtaintSortedDrawableEvents()
    
    override func setUp() {
        super.setUp()
        builder = EventsBuilder()
    }
    
    func test_getSortedEvents() {
        let result = builder.getSortedEvents(events: drawableEventsMock)
        
        XCTAssertEqual(sortedEvents.count, result.count)
        XCTAssertEqual(sortedEvents[0].first?.start, result[0].first?.start)
        XCTAssertEqual(sortedEvents[1].first?.start, result[1].first?.start)
        XCTAssertEqual(sortedEvents[1].first?.duration, result[1].first?.duration)
        XCTAssertEqual(sortedEvents[1].first?.name, result[1].first?.name)
    }

}
