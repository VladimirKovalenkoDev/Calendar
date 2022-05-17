//
//  CalendarView.swift
//  Calendar
//
//  Created by vladimir_kovalenko on 4/18/22.
//

import SwiftUI
import Combine

struct ScheduleView: View {
    
    @ObservedObject private var viewModel: ScheduleViewModel
    @Environment(\.managedObjectContext) var viewContext
    
    init(viewModel: ScheduleViewModel) {
        self.viewModel = viewModel
        
    }
    
    var body: some View {
        content
            .onAppear(perform: viewModel.viewDidAppear)
            .onDisappear(perform: viewModel.viewDisappear)
    }
    
    var content: some View {
        NavigationView {
            VStack {
//                DatePicker(
//                    "Select Day",
//                    selection: $viewModel.chosenDate,
//                    displayedComponents: .date
//                )
//                    .datePickerStyle(.compact)
//                    .padding(.top, 8)
//                    .padding(.leading, 16)
//                    .padding(.trailing, 16)
//                    .onChange(of: viewModel.chosenDate, perform: { _ in
//                        print("change")
//                    })
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
                            
//                            timeLine
//                                .padding(.top, 24)
//                                .id(2)
                    }
                        .onAppear {
                            proxy.scrollTo(1, anchor: .bottom)
                        }
                    }
                        VStack {
                            ForEach(0..<25) { index in
                                ScheduleRowView(time: viewModel.getTime(index: index))
                                    .frame(width: UIScreen.main.bounds.size.width, height: 78)
                                
                            }.padding(.leading, 20)
                        }.id(3)
                }
                .padding(.top, 8)
            }
            .navigationBarTitle("Schedule", displayMode: .inline)
        }
    }
    
    
//    var timeLine: some View {
//        Text("Text")
//    }
    
    var timeTracker: some View {
        CurrentTimeView(time: viewModel.currentDate.timeIn24HourFormat())
            .frame(width: UIScreen.main.bounds.size.width, height: 0)
    }
    
//    var datePicker: some View {
//        HStack {
//            Text("\(viewModel.chosenDate.dateWithShortMonth())")
//                .padding(.leading, 36)
//            Spacer()
//            Button {
//                viewModel.isPresented = true
//            } label: {
//                Image(systemName: "calendar")
//            }
//            .sheet(isPresented: $viewModel.isPresented) {
//                NewEventView(
//                    isPresented: $viewModel.isPresented,
//                    chosenDate: $viewModel.chosenDate
//                )
//            }
//            .frame(width: 40, height: 40, alignment: .center)
//            .padding(.trailing, 36)
//        }
//            .frame(width: UIScreen.main.bounds.size.width, height: 56)
//            .padding(.leading, -20)
//            .padding(.trailing, -20)
//            .overlay(
//                RoundedRectangle(cornerRadius: 5)
//                    .stroke(Color.gray, lineWidth: 1)
//            )
//    }
}
