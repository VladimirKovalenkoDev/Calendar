//
//  BaseEventCreationView.swift
//  Calendar
//
//  Created by vladimir_kovalenko on 5/27/22.
//

import SwiftUI

struct BaseEventCreationView: View {
    
    @Binding var eventName: String
    @Binding var startTime: Date
    @Binding var endTime: Date
    let range: Date?
    
    var body: some View {
        
        Form {
            Section() {
                TextField("Title",
                          text: $eventName)
            }
            Section() {
                VStack {
                    StartDatePicker(startTime: $startTime)
                    EndDatePicker(endTime: $endTime,
                                  range: range ?? Date()
                    )
                }
            }
        }
    }
    
    @ViewBuilder
    func StartDatePicker(startTime: Binding<Date>
    ) -> some View {
        DatePicker(
            "Starts",
            selection: startTime,
            displayedComponents: [.date, .hourAndMinute]
        )
    }
    
    @ViewBuilder
    func EndDatePicker(endTime: Binding<Date>,
                       range: Date
    ) -> some View {
        DatePicker(
            selection: endTime,
            in: range...,
            displayedComponents: [.date, .hourAndMinute]
        ) {
                Text("Ends")
            }
    }
}

