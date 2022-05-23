//
//  DetailEventView.swift
//  Calendar
//
//  Created by vladimir_kovalenko on 5/23/22.
//

import SwiftUI

struct DetailEventView: View {
    
    @ObservedObject private var viewModel: DetailEventViewModel
    @State private var showActionSheet = false
    @Environment(\.dismiss) var dismiss
    
    init(viewModel: DetailEventViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("\(viewModel.eventName)")
                    .padding(.leading, 16)
                    .font(.system(size: 24).bold())
                Spacer()
            }
            .padding(.bottom)
            
            Spacer()
            
            Text("Start: on \(viewModel.eventDate)")
            Text("from \(viewModel.startDate) to \(viewModel.endDate)")
            
            Spacer()
            
            Button("Delete Event") {
                showActionSheet.toggle()
            }
            .padding(.bottom)
            .actionSheet(isPresented: $showActionSheet) {
                ActionSheet(title: Text(""),
                            message: Text("Are you sure you want to delete this event"),
                            buttons: [
                                .cancel(),
                                .destructive(
                                    Text("Delete Event"),
                                    action: executeView
                                )
                            ]
                )
            }
        }
        .navigationBarTitle("Event Details", displayMode: .inline)
//        .toolbar {
//            ToolbarItem(placement: .navigationBarTrailing) {
//                Button {
//                    viewModel.openCurrentEvent()
//                } label: {
//                    Image(systemName: "plus")
//                        .foregroundColor(Color.red)
//                }
//            }
//        }
    }
}

// MARK: - private methods
extension DetailEventView {
    
    private func executeView() {
        viewModel.delete()
        dismiss()
    }
}
