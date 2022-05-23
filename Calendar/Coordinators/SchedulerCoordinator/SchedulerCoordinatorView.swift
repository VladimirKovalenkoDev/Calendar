//
//  SwiftUIView.swift
//  Calendar
//
//  Created by vladimir_kovalenko on 5/19/22.
//

import SwiftUI

struct SchedulerCoordinatorView: View {
    
    @ObservedObject var coordinator: SchedulerCoordinator
    
    var body: some View {
        if let viewModel = coordinator.viewModel {
            ScheduleView(viewModel: viewModel)
                .navigation(item: $coordinator.detailEventCoordinator, destination: { _ in
                    if let coordinator = coordinator.detailEventCoordinator {
                        DetailEventCoordinatorView(coordinator: coordinator)
                    }
                })
                .onAppear(perform: {
                    viewModel.dismiss()
                })
                .sheet(item: $coordinator.newEventViewModel) {
                    viewModel.dismiss()
                } content: {
                    NewEventView(viewModel: $0)
                }
        }
    }
}

