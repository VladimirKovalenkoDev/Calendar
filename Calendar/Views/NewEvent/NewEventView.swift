//
//  NewEventView.swift
//  Calendar
//
//  Created by vladimir_kovalenko on 4/23/22.
//

import SwiftUI

struct NewEventView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject private var viewModel: NewEventViewModel
    
    init(viewModel: NewEventViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section() {
                    TextField("Title", text: $viewModel.eventName)
                }
                Section() {
                    VStack {
                        DatePicker(selection: $viewModel.startTime, in: Date()...) {
                            Text("Starts")
                        }
                        DatePicker(selection: $viewModel.endTime, in: viewModel.startTime.addingTimeInterval(5*60)...) {
                            Text("Ends")
                        }
                    }
                }
            }
            .navigationTitle("New Event")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        viewModel.save()
                        dismiss()
                    }
                    .foregroundColor(Color.red)
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(Color.red)
                }
            }
        }
    }
}
