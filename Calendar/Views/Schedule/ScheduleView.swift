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
    
    @State var start: CGFloat = 0.0
    let timer = Timer.publish(every: 0, on: .main, in: .common).autoconnect()
    @State var currentDate = Date()
    
    
    var body: some View {
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
                Text("\(currentDate)")
                ScrollView {
                    ScrollViewReader { proxy in
                        GeometryReader { _ in
                            timeTracker
                                .padding(.leading, 20)
                                .padding(.top, start)
                                .padding(.top, 24)
                                .id(1)
                            timeLine
                                .padding(.top, 24)
                                .id(2)
                    }
                        .onAppear {
                            proxy.scrollTo(2, anchor: .center)
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
    
    
    var timeLine: some View {
        Text("Text")
    }
    
    var timeTracker: some View {
        CurrentTimeView(time: viewModel.chosenDate.timeIn24HourFormat())
            .onReceive(timer, perform: { input in
                start = CGFloat(86 * (viewModel.getHour(date: input) + viewModel.getMinute(date: input) / 60))
                currentDate = input
            })
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
