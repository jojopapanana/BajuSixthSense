//
//  LocationNotAllowedView.swift
//  BajuSixthSense
//
//  Created by Jovanna Melissa on 15/10/24.
//

import SwiftUI

struct LocationNotAllowedView: View {
    @Binding var isButtonDisabled: Bool
    
    var body: some View {
        VStack {
            Text("Can we get your location, please?")
                .font(.system(size: 22, weight: .semibold))
                .tracking(-0.4)
                .lineSpacing(2.8)
                .foregroundStyle(Color.systemBlack)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .padding(.bottom, 11)
            
            Text("We need it so we can show you all combinations you prefer.")
                .font(.system(size: 15, weight: .regular))
                .tracking(-0.4)
                .lineSpacing(2.0)
                .foregroundStyle(Color.systemGrey1)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .padding(.bottom, 11)
            
            Button {
                #warning("Redirect to settings for location")
            } label: {
                CustomButtonView(buttonType: .primary, buttonWidth: 212, buttonLabel: "Check Location Settings", isButtonDisabled: $isButtonDisabled)
            }
        }
        .padding(.horizontal, 84)
    }
}
