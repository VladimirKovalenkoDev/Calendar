//
//  NewEventViewModelTest.swift
//  CalendarTests
//
//  Created by vladimir_kovalenko on 6/1/22.
//

import XCTest
import CoreData
@testable import Calendar

class NewEventViewModelTest: XCTestCase {
    
    private let context = CoreManager.shared.container.viewContext

    func test_initViewModel() {
        let viewModel = NewEventViewModel(
            context: context,
            chosenDate: Date(),
            eventName: ""
        )
        XCTAssertNotNil(viewModel)
    }
    
    func test_save() {
        let viewModel = NewEventViewModel(
            context: context,
            chosenDate: Date(),
            eventName: ""
        )
        viewModel.save()
        XCTAssertTrue(Events(context: context).hasChanges)
    }
}
