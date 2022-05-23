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
        DetailEventView(viewModel: coordinator.viewModel!)
    }
}

