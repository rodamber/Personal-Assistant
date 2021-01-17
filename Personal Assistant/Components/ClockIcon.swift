//
//  ClockIcon.swift
//  Personal Assistant
//
//  Created by Rodrigo Bernardo on 17/01/2021.
//

import SwiftUI

struct ClockIcon: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.blue)
                .frame(width: 27, height: 27)
                .cornerRadius(3.0)
                .clipped()
            
            Image(systemName: "clock.fill")
                .background(Color.blue)
                .foregroundColor(.white)
        }
    }
}

struct ClockIcon_Previews: PreviewProvider {
    static var previews: some View {
        ClockIcon()
            .previewLayout(.sizeThatFits)
    }
}
