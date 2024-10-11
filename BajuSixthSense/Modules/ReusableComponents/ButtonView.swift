//
//  ButtonView.swift
//  BajuSixthSense
//
//  Created by Jovanna Melissa on 10/10/24.
//

import SwiftUI

struct ButtonView: View {
    var buttonText:String
    
    var body: some View {
        Text(buttonText)
            .foregroundStyle(.white)
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .background(RoundedRectangle(cornerRadius: 40).fill(.black))
        
    }
}

#Preview {
    ButtonView(buttonText: "Continue")
}
