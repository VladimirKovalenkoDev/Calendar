//
//  EventLayoutView.swift
//  Calendar
//
//  Created by vladimir_kovalenko on 5/17/22.
//

import SwiftUI

struct EventLayoutView: View {
    var title: String
    var color: Color
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        Rectangle()
            .fill(color)
            .opacity(0.5)
            .frame(width: width,
                   height: height)
            .overlay(
                GeometryReader { _ in
                    Text(title)
                        .padding(.top, 5)
                        .padding(.leading, 8)
                        .padding(.bottom, 3)
                        .font(.system(size: 18))
                        .frame(width: width,
                               alignment: .leading)
                        .minimumScaleFactor(0.2)
                        .lineLimit(1)
                }
            )
    }
}

struct EventLayoutView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            EventLayoutView(title: "name", color: Color.red, width: 200, height: 800)
        }
    }
}
