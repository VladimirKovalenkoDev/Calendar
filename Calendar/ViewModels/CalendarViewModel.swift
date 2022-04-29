//
//  CalendarViewModel.swift
//  Calendar
//
//  Created by vladimir_kovalenko on 4/27/22.
//

import Foundation

final class CalendarViewModel: ObservableObject {
    
    @Published var currentMonth: Int
    @Published var currentDate: Date
    
    init() {
        self.currentMonth = 0
        self.currentDate = Date()
        
    }
    
    func extractDate(currentMonth: Int) -> [DateValue] {
        let calendar = Calendar.current
        
        let currentMonth = getCurrentMonth(currentMonth: currentMonth)
        
        var days = currentMonth.getAllDates().compactMap { date -> DateValue in
            let day = calendar.component(.day, from: date)
            return DateValue(day: day, date: date)
        }
        
        var firstWeekDayOfMonth = calendar.component(.weekday,
                                                     from: days.first?.date ?? Date())
        //switch from the weekday units are the numbers 1 through N (where for the Gregorian calendar N=7 and 1 is Sunday)
        switch firstWeekDayOfMonth {
        case 1:
            firstWeekDayOfMonth = 7
        case 2:
            firstWeekDayOfMonth = 1
        case 3:
            firstWeekDayOfMonth = 2
        case 4:
            firstWeekDayOfMonth = 3
        case 5:
            firstWeekDayOfMonth = 4
        case 6 :
            firstWeekDayOfMonth = 5
        case 7 :
            firstWeekDayOfMonth = 6
        default:
            print("error")
        }
        
        for _ in 0..<firstWeekDayOfMonth - 1 {
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        
        return days
    }
    
    func getMonthAndYear() -> [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "LLLL YYYY"
        let date = formatter.string(from: currentDate)
        return date.components(separatedBy: " ")
    }
    
    func getCurrentMonth(currentMonth: Int) -> Date {
        let calendar = Calendar.current
        guard let currentMonth = calendar.date(
            byAdding: .month,
            value: currentMonth,
            to: Date()
        ) else { return Date() }
        return currentMonth
    }
}
