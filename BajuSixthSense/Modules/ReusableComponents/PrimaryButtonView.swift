//
//  PrimaryButtonView.swift
//  BajuSixthSense
//
//  Created by Jovanna Melissa on 12/10/24.
//

import SwiftUI

struct PrimaryButtonView: View {
    var buttonWidth:CGFloat
    var buttonLabel:String
    @Binding var isButtonDisabled:Bool
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 12)
                .fill(isButtonDisabled ? .disabledGreyBackground : .systemPurple)
                .frame(width: buttonWidth, height: 50)
            
            Text(buttonLabel)
                .foregroundStyle(isButtonDisabled ? .disabledGreyLabel : .white)
        }
    }
}

//#Preview {
//    PrimaryButtonView(buttonWidth: 360, buttonLabel: "Save")
//}
