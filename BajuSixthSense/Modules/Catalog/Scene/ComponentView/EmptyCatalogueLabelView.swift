//
//  EmptyCatalogueLabelView.swift
//  BajuSixthSense
//
//  Created by Jovanna Melissa on 15/10/24.
//

import SwiftUI

struct EmptyCatalogueLabelView: View {
    @EnvironmentObject var navigationRouter: NavigationRouter
    @State private var isButtonDisabled = false    
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Upload baju bekasmu dan ikut jadi agen pengubah dunia!\n")
                .font(.title3)
                .fontWeight(.semibold)
            
            Text("Dengan mem-posting baju bekasmu, itu akan mengurangi polusi di lingkungan. Ayo mulai sekarang!")
                .font(.footnote)
                .foregroundStyle(Color.labelSecondary2)
            
            HStack {
                Button {
                    navigationRouter.push(to: .Upload)
                } label: {
                    Spacer()
                    CustomButtonView(buttonType: .primary, buttonWidth: 158, buttonLabel: "Upload", isButtonDisabled: $isButtonDisabled)
                }
            }
            .padding(.top, 24)
        }
        .padding(.top, 86)
        .padding(.vertical)
        .padding(.horizontal)
        .background(
            Rectangle()
                .foregroundStyle(Color.disabledBackgroundGrey)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.black, lineWidth: 0.33)
                )
                .padding(.top, 86)
        )
    }
}

#Preview {
    EmptyCatalogueLabelView()
}
