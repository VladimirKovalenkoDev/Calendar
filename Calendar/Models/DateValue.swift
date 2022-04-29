//
//  DateValue.swift
//  Calendar
//
//  Created by vladimir_kovalenko on 4/27/22.
//

import Foundation

struct DateValue: Identifiable {
    var id = UUID().uuidString
    let day: Int
    let date: Date
}
