//
//  EmptyCatalogueLabelView.swift
//  BajuSixthSense
//
//  Created by Jovanna Melissa on 15/10/24.
//

import SwiftUI

struct EmptyCatalogueLabelView: View {
    @State private var isButtonDisabled = false
    var body: some View {
        VStack(alignment: .leading) {
            Text("Upload your Unused Clothes and Be Agent of Change\n")
                .font(.title3)
                .fontWeight(.semibold)
            
            
            Text("By uploading and sharing your unused clothes, it would minimizing environment pollution. Let’s start and make your move.")
                .font(.footnote)
                .foregroundStyle(Color.systemGrey1)
            
            HStack {
                NavigationLink {
//                    UploadClothView()
                } label: {
                    Spacer()
                    CustomButtonView(buttonType: .primary, buttonWidth: 158, buttonLabel: "Upload", isButtonDisabled: $isButtonDisabled)
                }
            }
            .padding(.top, 24)
        }
        .padding(.vertical)
        .padding(.horizontal)
        .background(
            Rectangle()
                .foregroundStyle(Color.systemGrey2)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.black, lineWidth: 0.33)
                )
        )
    }
}

#Preview {
    EmptyCatalogueLabelView()
}
