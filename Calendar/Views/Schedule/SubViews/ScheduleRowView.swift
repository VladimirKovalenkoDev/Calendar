//
//  ScheduleRow.swift
//  Calendar
//
//  Created by vladimir_kovalenko on 4/18/22.
//

import SwiftUI

struct ScheduleRowView: View {
    
    var time: String
    
    var body: some View {
        HStack {
            Text(time)
                .scaledToFill()
                .foregroundColor(Color.gray)
                .font(.system(size: 12))
                .frame(width: 32, height: 16,alignment: .leading)
            Rectangle()
                .fill(Color.gray)
                .frame(height: 0.5)
                .padding(.leading, 8)
           
        }.padding(.top, -40)
    }
}

struct ScheduleRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ScheduleRowView(time: "00:00")
        }
                .previewLayout(.fixed(width: 300, height: 80))
    }
}
