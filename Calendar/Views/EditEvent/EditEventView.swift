//
//  EditEventView.swift
//  Calendar
//
//  Created by vladimir_kovalenko on 5/27/22.
//

import SwiftUI

struct EditEventView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject private var viewModel: EditEventViewModel
    
    init(viewModel: EditEventViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            BaseEventCreationView(
                eventName: $viewModel.eventName,
                startTime: $viewModel.startTime,
                endTime: $viewModel.endTime,
                range: viewModel.startTime.addingTimeInterval(5*60)
            )
                .navigationTitle("Edit Event")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Edit") {
                            viewModel.edit()
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
