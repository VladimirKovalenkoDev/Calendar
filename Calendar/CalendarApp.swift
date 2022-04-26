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
            let viewModel = ScheduleViewModel(context: viewContext)
//                                              ,
//                                              coordinator: coordinator)
//            ScheduleView(viewModel: viewModel)
//                .environment(\.managedObjectContext, viewContext)
            CalendarView()
        }
    }
}
