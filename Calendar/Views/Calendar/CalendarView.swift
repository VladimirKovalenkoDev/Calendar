//
//  CalendarView.swift
//  Calendar
//
//  Created by vladimir_kovalenko on 4/26/22.
//

import SwiftUI

struct CalendarView: View {
    
    @ObservedObject private var viewModel: CalendarViewModel
    
    init(viewModel: CalendarViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        monthView
    }
    
    var monthView: some View {
        VStack(spacing: 35) {
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text(viewModel.getMonthAndYear()[1])
                        .font(.caption)
                        .fontWeight(.semibold)
                    Text(viewModel.getMonthAndYear()[0])
                        .font(.title.bold())
                        .textCase(.uppercase)
                }
                .padding(.horizontal)
               Spacer()
            }
            HStack(spacing: 0) {
                ForEach(C.days, id: \.self){ day in
                    Text(day)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                }
            }
            let columns = Array(
                repeating: GridItem(.flexible()),
                count: 7
            )
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(viewModel.extractDate()) { value in
                    CardView(value: value)
                }
            }
        }
    }
    
    @ViewBuilder
    func CardView(value: DateValue) -> some View {
        VStack {
            if value.day != -1 {
                Text("\(value.day)")
            }
        }
       
    }
}
