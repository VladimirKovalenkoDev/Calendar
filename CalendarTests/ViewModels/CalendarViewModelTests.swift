//
//  CalendarViewModelTests.swift
//  CalendarTests
//
//  Created by vladimir_kovalenko on 5/26/22.
//

import XCTest
import CoreData
import Foundation
@testable import Calendar

class CalendarViewModelTests: XCTestCase {
    private let context = CoreManager.shared.container.viewContext
    private let calendar = Calendar.current
    private let date = Date()
    
    override class func setUp() {
        super.setUp()
    }
    
    func test_viewModelInitialization() {
        let calendarViewModel = CalendarViewModel(
            coordinator: CalendarCoordinator(context: context)
        )
       
        
        XCTAssertNotNil(calendarViewModel)
    }
    
    func test_extractDate() {
        let calendarViewModel = CalendarViewModel(
            coordinator: CalendarCoordinator(context: context)
        )
        let  month = calendarViewModel.extractDate(currentMonth: 0)
        var daysInMonth = month
        
        daysInMonth.removeAll { value in
            return value.day == -1
        }
        let days = calendar.range(of: .day, in: .month, for: date)?.count
        
        XCTAssertNotNil(month)
        XCTAssertEqual(daysInMonth.count, days)
    }
    
    func test_getMonthAndYear() {
        let calendarViewModel = CalendarViewModel(
            coordinator: CalendarCoordinator(context: context)
        )
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        let nameOfMonth = dateFormatter.string(from: date)
        XCTAssertEqual(calendarViewModel.getMonthAndYear(currentMonth: 0)[0],
                       nameOfMonth)
        XCTAssertEqual(calendarViewModel.getMonthAndYear(currentMonth: 0)[1], "\(year)")
    }
}
