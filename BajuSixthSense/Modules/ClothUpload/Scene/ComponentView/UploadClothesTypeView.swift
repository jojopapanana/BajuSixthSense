//
//  UploadClothesTypeView.swift
//  MacroChallenge
//
//  Created by PadilKeren on 04/10/24.
//

import SwiftUI

struct UploadClothesTypeView: View {
    @Binding var selectedClothesType: Set<String>
    let options1 = ["Shirt", "T-Shirt", "Sweater", "Hoodies", "Long Pants", "Skirts", "Shorts", "Jacket"]
    
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
                ForEach(options1, id: \.self) { option in
                    selectedTypeButton(label: option, selectedClothesTypes: $selectedClothesType)
                }
            }
            .padding(.horizontal)
        }
    }
    
    @ViewBuilder
    func selectedTypeButton(label: String, selectedClothesTypes: Binding<Set<String>>) -> some View {
        Button(action: {
            if selectedClothesTypes.wrappedValue.contains(label) {
                selectedClothesTypes.wrappedValue.remove(label)
            } else {
                selectedClothesTypes.wrappedValue.insert(label)
            }
        }) {
            Text(label)
                .font(.system(size: 15, weight: .regular))
                .tracking(-0.23)
                .padding(.horizontal, 14)
                .padding(.vertical, 7)
                .frame(height: 34)
                .background(selectedClothesTypes.wrappedValue.contains(label) ? Color.systemBlack : Color.systemWhite)
                .foregroundColor(selectedClothesTypes.wrappedValue.contains(label) ? Color.systemWhite : Color.systemBlack)
                .cornerRadius(18)
                .overlay(
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(selectedClothesTypes.wrappedValue.contains(label) ? Color.clear : Color.systemBlack, lineWidth: 1)
                )
        }
    }
}
