//
//  PrimaryButtonView.swift
//  BajuSixthSense
//
//  Created by Jovanna Melissa on 12/10/24.
//

import SwiftUI

struct CustomButtonView: View {
    var buttonType: ButtonType
    var buttonWidth: CGFloat
    var buttonLabel: String
    @Binding var isButtonDisabled: Bool
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 12)
                .stroke(isButtonDisabled && buttonType != .primary ? .labelPrimary : buttonType.strokeColor, lineWidth: 1)
                .fill(isButtonDisabled ? .labelPrimary : buttonType.fill)
                .frame(width: buttonWidth, height: 50)
            
            Text(buttonLabel)
                .foregroundStyle(isButtonDisabled ? .labelPrimary : buttonType.textColor)
        }
    }
}

enum ButtonType{
    case primary
    case secondary
    case destructive
}

