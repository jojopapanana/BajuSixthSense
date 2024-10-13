//
//  PrimaryButtonView.swift
//  BajuSixthSense
//
//  Created by Jovanna Melissa on 12/10/24.
//

import SwiftUI

struct CustomButtonView: View {
    var buttonType:ButtonType
    var buttonWidth:CGFloat
    var buttonLabel:String
    @Binding var isButtonDisabled:Bool
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 12)
                .stroke(isButtonDisabled && buttonType != .primary ? .systemGrey1 : buttonType.strokeColor, lineWidth: 1)
                .fill(isButtonDisabled ? .disabledGreyBackground : buttonType.fill)
                .frame(width: buttonWidth, height: 50)
            
            Text(buttonLabel)
                .foregroundStyle(isButtonDisabled ? .disabledGreyLabel : buttonType.textColor)
        }
    }
}

//#Preview {
//    CustomButtonView(buttonWidth: 360, buttonLabel: "Save")
//}
