//
//  EditEventViewModelTests.swift
//  CalendarTests
//
//  Created by vladimir_kovalenko on 6/1/22.
//

import XCTest
import CoreData
@testable import Calendar

class EditEventViewModelTests: XCTestCase {

    private let context = CoreManager.shared.container.viewContext
    private let selectedEvent = EventsViewModelMock.getEventViewModel()
    
    func test_initViewModel() {
        let viewModel = EditEventViewModel(
            context: context,
            selectedEvent: selectedEvent
        )
        XCTAssertNotNil(viewModel)
    }
    
    func test_save() {
        let viewModel = EditEventViewModel(
            context: context,
            selectedEvent: selectedEvent
        )
        viewModel.edit()
        XCTAssertTrue(Events(context: context).hasChanges)
    }
}
