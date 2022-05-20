//
//  CalendarCoordinatorView.swift
//  Calendar
//
//  Created by vladimir_kovalenko on 5/18/22.
//

import SwiftUI

struct CalendarCoordinatorView: View {
    
    @ObservedObject var coordinator: CalendarCoordinator
    
    var body: some View {
        NavigationView {
            CalendarView(viewModel: coordinator.viewModel)
                .navigation(item: $coordinator.scheduleCoordinator) { viewModel in
                    if let scheduleCoordinator = coordinator.scheduleCoordinator {
                        SchedulerCoordinatorView(coordinator: scheduleCoordinator)
                    }
                }
                .listStyle(.plain)
                .navigationTitle("Month")
                .navigationBarTitleDisplayMode(.inline)
                .sheet(item: $coordinator.newEventViewModel) {
                    NewEventView(viewModel: $0)
                }
        }
        .accentColor(.red)
    }
}
