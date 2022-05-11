//
//  CalendarView.swift
//  Calendar
//
//  Created by vladimir_kovalenko on 4/26/22.
//

import SwiftUI

struct CalendarView: View {
    
    @ObservedObject private var viewModel: CalendarViewModel
    @State var isPresented: Bool
    
    init(viewModel: CalendarViewModel) {
        self.viewModel = viewModel
        self.isPresented = false
    }
    
    var body: some View {
        NavigationView {
            List(viewModel.currentMonth..<12) { month in
                CalendarList(month: month)
            }
            .listStyle(.plain)
            .navigationTitle("Month")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isPresented.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                    .sheet(isPresented: $isPresented) {
                        NewEventView()
                    }

                }
            }
        }
    }
    
    @ViewBuilder
    func CardView(value: DateValue) -> some View {
        VStack {
            if value.day != -1 {
                if let task = viewModel.events.first(
                    where: { task in
                        return viewModel.isSameDate(
                            first: task.eventDate,
                            second: value.date
                        )
                    }
                ) {
                    Text("\(value.day)")
                        .foregroundColor(viewModel
                                            .isSameDate(first: task.eventDate,
                                                        second: viewModel.currentDate) ? .white:
                                                .primary)
                        .frame(maxWidth: .infinity)
                    Spacer()
                    Circle()
                        .fill(
                            viewModel
                                .isSameDate(first: task.eventDate,
                                            second: viewModel.currentDate) ? .white:
                                Color.red
                        )
                        .frame(width: 8, height: 8)
                } else {
                    Text("\(value.day)")
                        .foregroundColor(viewModel
                                            .isSameDate(first: value.date,
                                                        second: viewModel.currentDate) ? .white: .primary)
                        .frame(maxWidth: .infinity)
                    
                    Spacer()
                }
                
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
                                .opacity(
                                    viewModel
                                        .isSameDate(first: value.date,
                                                    second: viewModel.currentDate) ? 1 : 0
                                )
                        )
                        .onTapGesture {
                            viewModel.currentDate = value.date
                        }
                }
            }
        }
    }
}
