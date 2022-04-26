//
//  Extension+Date.swift
//  Calendar
//
//  Created by vladimir_kovalenko on 4/22/22.
//

import Foundation

extension Date {
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
    
    func getAllDates() -> [Date] {
        let calendar = Calendar.current
        
        guard let range = calendar.range(
            of: .day,
            in: .month,
            for: self
        ) else { return [Date()] }
        
        return range.compactMap { day -> Date in
            return calendar.date(byAdding: .day, value: day, to: self) ?? Date()
        }
    }
}
