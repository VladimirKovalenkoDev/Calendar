//
//  CalendarView.swift
//  Calendar
//
//  Created by vladimir_kovalenko on 4/18/22.
//

import SwiftUI

struct ScheduleView: View {
    
    @ObservedObject private var viewModel: ScheduleViewModel
    
    init(viewModel: ScheduleViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        content
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.openNewEvent(viewModel.chosenDate)
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(Color.red)
                    }
                }
            }
            .onDisappear(perform: viewModel.viewDisappear)
        
    }
    
    var content: some View {
            VStack {
                Text(viewModel.chosenDate.dateWithDayOfTheWeek())
                ScrollView {
                    ScrollViewReader { proxy in
                        GeometryReader { _ in
                            if viewModel.isSameDate(
                                first: viewModel.chosenDate,
                                second: Date()
                            ) {
                                timeTracker
                                    .padding(.leading, 20)
                                    .padding(.top, CGFloat(86 * viewModel.currentTimeHourPosition))
                                    .padding(.top, 24)
                                    .id(1)
                            } else {
                                timeTracker.hidden()
                            }
                            
                            timeLine
                                .padding(.top, 24)
                                .id(2)
                    }
                        .onAppear {
                            proxy.scrollTo(2, anchor: .bottom)
                        }
                    }
                        VStack {
                            ForEach(0..<25) { index in
                                ScheduleRowView(time: getTime(index: index))
                                    .frame(width: UIScreen.main.bounds.size.width, height: 78)
                                
                            }.padding(.leading, 20)
                        }.id(3)
                }
                .padding(.top, 8)
            }
            .navigationBarTitle("Schedule", displayMode: .inline)
        }
    
    
    var timeLine: some View {
        ForEach(0..<viewModel.drawableArrayEvents.count, id: \.self) { columnIndex in
            let drawEvents = viewModel.drawableArrayEvents[columnIndex]
            let count = viewModel.drawableArrayEvents.count
            let width = UIScreen.main.bounds.size.width
            let columnWidth = (width - 62 + CGFloat(4 - (count * 2))
            ) / CGFloat(count)
            ForEach(0..<drawEvents.count, id: \.self) { index in
                let drawEvent = drawEvents[index]
                EventLayoutView(
                    title: drawEvent.name,
                    color: Color.red,
                    width: columnWidth,
                    height: CGFloat(86 * drawEvent.duration)
                )
                    .frame(width: columnWidth,
                           height: CGFloat(86 * drawEvent.duration))
                    .padding(.top, CGFloat(86 * drawEvent.start))
                    .padding(.leading, getStartPoint(columnWidth: columnWidth, columnIndex: columnIndex))
                    .onTapGesture {
                        viewModel.openDetailEvent(drawEvent.master)
                    }
            }
        }
    }
    
    var timeTracker: some View {
        CurrentTimeView(time: viewModel.currentDate.timeIn24HourFormat())
            .frame(width: UIScreen.main.bounds.size.width, height: 0)
    }
}

// MARK: - private methods
extension ScheduleView {
    private func getStartPoint(columnWidth: CGFloat,
                               columnIndex: Int) -> CGFloat {
        if columnIndex > 0 {
            return columnWidth * CGFloat(columnIndex) + 68 + CGFloat(2 * columnIndex)
        }
        return 68
    }
    
    private func getTime(index: Int) -> String {
        if index < 10 {
            return "0\(index):00"
        } else {
            return "\(index):00"
        }
    }
}
