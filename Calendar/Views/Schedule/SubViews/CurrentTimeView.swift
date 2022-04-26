//
//  CurrentTimeView.swift
//  Calendar
//
//  Created by vladimir_kovalenko on 4/18/22.
//

import SwiftUI

struct CurrentTimeView: View {
    
    var time: String
    
    var body: some View {
        ZStack {
            HStack {
                Text(time)
                    .scaledToFill()
                    .foregroundColor(Color.red)
                    .font(.system(size: 12))
                    .frame(width: 32,
                           height: 16,
                           alignment: .leading)
                Rectangle()
                    .fill(Color.red)
                    .frame(height: 1)
                    .padding(.leading, 8)
            }
            Circle()
                .fill(Color.red)
                .frame(width: 5,
                       height: 5,
                       alignment: .leading)
                .padding(.trailing,
                         UIScreen.main.bounds.size.width - 100)
        }
    }
}

struct CurrentTimeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CurrentTimeView(time: "00:00")
        }
        .previewLayout(.fixed(width: UIScreen.main.bounds.size.width, height: 80))
         }
    }
