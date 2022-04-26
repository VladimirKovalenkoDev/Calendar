//
//  CalendarViewModel.swift
//  Calendar
//
//  Created by vladimir_kovalenko on 4/18/22.
//

import Foundation
import Combine
import CoreData
import SwiftUI

final class ScheduleViewModel: ObservableObject {
    
    private (set) var context: NSManagedObjectContext
    @Published var chosenDate: Date
    @Published var isPresented: Bool
   // private unowned let coordinator: CalendarCoordinator
    
    init(context: NSManagedObjectContext)
//         ,
//         coordinator: CalendarCoordinator)
    {
        self.chosenDate = Date()
        self.context = context
        self.isPresented = false
      //  self.coordinator = coordinator
    }
    
    func getTime(index: Int) -> String {
        if index < 10 {
            return "0\(index):00"
        } else {
            return "\(index):00"
        }
    }
    
    func getHour(date: Date) -> Float {
        let calendar = Calendar.current
        return Float(calendar.component(.hour, from: date))
    }
    
    func getMinute(date: Date) -> Float {
        let calendar = Calendar.current
        return Float(calendar.component(.minute, from: date))
    }
    
    func getCurrentTime(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }    
}
