//
//  UploadButtonView.swift
//  BajuSixthSense
//
//  Created by Jovanna Melissa on 15/10/24.
//

import SwiftUI

struct UploadButtonView: View {
    @Binding var isButtonDisabled: Bool
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 59, height: 59)
                .foregroundStyle(!isButtonDisabled ? Color.systemPurple : .disabledBackgroundGrey)
                .shadow(radius: 4, y: 4)
            Image(systemName: "plus")
                .resizable()
                .frame(width: 28, height: 28)
                .foregroundStyle(Color.systemPureWhite)
                .font(.system(size: 28, weight: .bold))
        }
        .padding(.trailing, 16)
        .padding(.top, 10)
    }
}
