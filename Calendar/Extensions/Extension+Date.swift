//
//  Extension+Date.swift
//  Calendar
//
//  Created by vladimir_kovalenko on 4/22/22.
//

import Foundation

extension Date {
        
    func onlyDateFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: self)
    }
    
    func add(hours: Int) -> Date {
        return Calendar.current.date(byAdding: .hour, value: hours, to: self) ?? Date()
    }
    
    func timeIn24HourFormat() -> String {
            let formatter = DateFormatter()
            formatter.dateStyle = .none
            formatter.dateFormat = "HH:mm"
            return formatter.string(from: self)
        }
    
    func dateWithShortMonth() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM YYYY"
        return formatter.string(from: self)
    }
    
    func dateWithDayOfTheWeek() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE dd MMMM YYYY"
        return formatter.string(from: self).capitalized
    }
    
    func getAllDates() -> [Date] {
        let calendar = Calendar.current
        
        guard let  range = calendar.range(
            of: .day,
            in: .month,
            for: self
        ) else { return [Date()] }
       
        
        let startDate = calendar.date(
            from: Calendar.current.dateComponents([.year, .month],
                                                  from: self)
        ) ?? Date()
        
        return range.compactMap { day -> Date in
            return calendar.date(byAdding: .day, value: day - 1, to: startDate) ?? Date()
        }
    }
}
