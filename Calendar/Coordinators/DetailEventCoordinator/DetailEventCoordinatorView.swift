//
//  DetailEventCoordinatorView.swift
//  Calendar
//
//  Created by vladimir_kovalenko on 5/23/22.
//

import SwiftUI

struct DetailEventCoordinatorView: View {
    
    @ObservedObject var coordinator: DetailEventCoordinator
    
    var body: some View {
        if let viewModel = coordinator.viewModel {
            DetailEventView(viewModel: viewModel)
                .sheet(item: $coordinator.editEventViewModel) {
                    viewModel.updateView()
                } content: {
                    EditEventView(viewModel: $0)
                }
        }
    }
}

