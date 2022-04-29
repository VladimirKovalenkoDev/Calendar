//
//  CalendarViewModel.swift
//  Calendar
//
//  Created by vladimir_kovalenko on 4/27/22.
//

import Foundation

final class CalendarViewModel: ObservableObject {
    
    @Published private var currentMonth: Int
    @Published var currentDate: Date
    init() {
        self.currentMonth = 0
        self.currentDate = Date()
        
    }
    func extractDate() -> [DateValue] {
        let calendar = Calendar.current
        
        let currentMonth = getCurrentMonth()
        
        var days = currentMonth.getAllDates().compactMap { date -> DateValue in
            let day = calendar.component(.day, from: date)
            return DateValue(day: day, date: date)
        }
        
        let firstWeekDayOfMonth = calendar.component(.weekday,
                                                     from: days.first?.date ?? Date())
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
    
    func getCurrentMonth() -> Date {
        let calendar = Calendar.current
        guard let currentMonth = calendar.date(
            byAdding: .month,
            value: currentMonth,
            to: Date()
        ) else { return Date() }
        return currentMonth
    }
}
