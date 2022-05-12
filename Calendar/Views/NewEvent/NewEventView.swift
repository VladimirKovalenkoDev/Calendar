//
//  NewEventView.swift
//  Calendar
//
//  Created by vladimir_kovalenko on 4/23/22.
//

import SwiftUI

struct NewEventView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Text("ddd")
        VStack{
//            DatePicker(
//                "Select Day",
//                selection: $chosenDate,
//                displayedComponents: .date
//            )
//                .datePickerStyle(.graphical)
//                .padding(.top, 24)
//                .padding(.leading, 16)
//                .padding(.trailing, 16)
//                .onChange(of: chosenDate, perform: { _ in
//                    print("change")
//                })
            Button("Done") {
                dismiss()
            }

        }
    }
}
