//
//  CustomToggleView.swift
//  ProfileBajuSixthSense_1
//
//  Created by PadilKeren on 08/11/24.
//

import SwiftUI

struct CustomToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            
            // Custom background
            RoundedRectangle(cornerRadius: 50)
                .fill(configuration.isOn ? Color.labelPrimary : Color.labelTertiary)
                .frame(width: 44, height: 24)
            
            // Knob (circle)
            Circle()
                .fill(Color.systemPureWhite)
                .frame(width: 20, height: 20)
                .offset(x: configuration.isOn ? -30 : -50)
                .animation(.easeInOut, value: configuration.isOn)
        }
        .onTapGesture {
            configuration.isOn.toggle()
        }
    }
}

#Preview {
    EditCardView()
}
