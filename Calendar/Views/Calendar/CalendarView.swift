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
                        List(viewModel.currentMonth..<12) { month in
                            CalendarList(month: month)
                        }
                        .listStyle(.plain)
    }
        
    @ViewBuilder
    func CardView(value: DateValue) -> some View {
        VStack {
            if value.day != -1 {
                Text("\(value.day)")
               
            }
        }
        .padding(.vertical, 8)
        .frame(
               height: 60,
               alignment: .top
        )
    }
    
    @ViewBuilder
    func CalendarList(month: Int) -> some View {
        VStack(spacing: 35) {
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text(viewModel.getMonthAndYear(currentMonth: month)[1])
                        .font(.caption)
                        .fontWeight(.semibold)
                    Text(viewModel.getMonthAndYear(currentMonth: month)[0])
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
                repeating: GridItem(.flexible(), spacing: 15, alignment: .center),
                count: 7
            )
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(viewModel.extractDate(currentMonth: month)) { value in
                    CardView(value: value)
                        .background(
                           RoundedRectangle(cornerRadius: 5)
                                .fill(Color.gray)
                                .padding(.horizontal, 8)
                                //.opacity()
                        )
                }
            }
        }
    }
}
