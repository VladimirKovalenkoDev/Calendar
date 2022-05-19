//
//  CalendarApp.swift
//  Calendar
//
//  Created by vladimir_kovalenko on 4/18/22.
//

import SwiftUI

@main
struct CalendarApp: App {
    
    @StateObject var coordinator = CalendarCoordinator(context: CoreManager.shared.container.viewContext)
    
    var body: some Scene {
        WindowGroup {
            CalendarCoordinatorView(coordinator: coordinator)
        }
    }
}
