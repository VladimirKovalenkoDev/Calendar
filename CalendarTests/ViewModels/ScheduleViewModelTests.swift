//
//  ScheduleViewModelTests.swift
//  CalendarTests
//
//  Created by vladimir_kovalenko on 6/1/22.
//

import XCTest
import CoreData
@testable import Calendar

class ScheduleViewModelTests: XCTestCase {
    
    private let context = CoreManager.shared.container.viewContext
    private let eventsViewModelMock = EventsViewModelMock.getEventViewModel()
    private let drawableEventsModelMock = DrawableEventsModelMock.obtainDrawableEvents()
    
    func test_initViewModel() {
        let scheduleViewModel = ScheduleViewModel(
            chosenDate: Date(),
            coordinator: SchedulerCoordinator(
                context: context,
                date: Date(),
                parent: CalendarCoordinator(context: context)
            )
        )
        
        XCTAssertNotNil(scheduleViewModel)
    }
    
    func test_isSameDate() {
        let scheduleViewModel = ScheduleViewModel(
            chosenDate: Date(),
            coordinator: SchedulerCoordinator(
                context: context,
                date: Date(),
                parent: CalendarCoordinator(context: context)
            )
        )
        
        XCTAssertNotNil(scheduleViewModel.isSameDate(first: Date(), second: Date()))
        XCTAssertTrue(scheduleViewModel.isSameDate(first: Date(), second: Date()))
    }
}
