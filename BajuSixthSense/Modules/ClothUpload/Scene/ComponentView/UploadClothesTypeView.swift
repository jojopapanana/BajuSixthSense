//
//  UploadClothesTypeView.swift
//  MacroChallenge
//
//  Created by PadilKeren on 04/10/24.
//

import SwiftUI

struct UploadClothesTypeView: View {
//    @Binding var selectedClothesType: [String]
//    let options1 = ["Shirt", "T-Shirt", "Sweater", "Hoodies", "Long Pants", "Skirts", "Shorts", "Jacket"]
    
    @ObservedObject var uploadVM: UploadClothViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Clothes Type")
                .font(.system(size: 17, weight: .semibold))
                .tracking(-0.4)
                .foregroundStyle(Color.systemBlack)
                .padding(.horizontal)
            
            Text("What type of clothes are included in your clothes bulk?")
                .font(.system(size: 13))
                .tracking(-0.4)
                .foregroundStyle(Color.systemGrey1)
                .padding(.horizontal)
            
            Divider()
                .frame(width: 350)
                .foregroundStyle(Color.systemGrey1)
                .padding(.horizontal)
                .padding(.bottom, 10)
            
            WrappedHStack(verticalSpacing: 10, horizontalSpacing: 10) {
                ForEach(uploadVM.fetchClothType(), id: \.self) { option in
                    selectedTypeButton(label: option)
                }
            }
            .padding(.horizontal)
        }
    }
    
    @ViewBuilder
    func selectedTypeButton(label: ClothType) -> some View {
        Button {
            if uploadVM.checkCategory(type: label) {
                uploadVM.removeCategoryType(type: label)
            } else {
                uploadVM.addCategoryType(type: label)
            }
        } label: {
            Text(label.rawValue)
                .font(.system(size: 15, weight: .regular))
                .tracking(-0.23)
                .padding(.horizontal, 14)
                .padding(.vertical, 7)
                .frame(height: 34)
                .background(
                    uploadVM.checkCategory(type: label) ? Color.systemBlack : Color.systemWhite
                )
                .foregroundColor(
                    uploadVM.checkCategory(type: label) ? Color.systemWhite : Color.systemBlack
                )
                .cornerRadius(18)
                .overlay(
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(
                            uploadVM.checkCategory(type: label) ? Color.clear : Color.systemBlack,
                            lineWidth: 1
                        )
                )
        }
    }
}
