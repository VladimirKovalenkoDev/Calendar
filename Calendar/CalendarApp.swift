//
//  CalendarApp.swift
//  Calendar
//
//  Created by vladimir_kovalenko on 4/18/22.
//

import SwiftUI

@main
struct CalendarApp: App {
//    @StateObject var coordinator = CalendarCoordinator()
    var body: some Scene {
        WindowGroup {
            let viewContext = CoreManager.shared.container.viewContext
            CalendarView(viewModel: CalendarViewModel(context: viewContext))
        }
    }
}
