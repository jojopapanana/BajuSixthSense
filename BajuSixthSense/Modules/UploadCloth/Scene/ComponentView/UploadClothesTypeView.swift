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
                .font(.custom("Montserrat-SemiBold", size: 17))
                .padding(.horizontal)
            
            Text("What type of clothes are included in your clothes bulk?")
                .padding(.horizontal)
                .font(.system(size: 13))
                .tracking(-0.4)
                .foregroundStyle(Color.gray)
                .lineLimit(1)
            
            Rectangle()
                .frame(width: 350, height: 0.3)
                .foregroundStyle(Color.gray)
                .padding(.horizontal)
                .padding(.bottom, 15)
            
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
                .font(.system(size: 15))
                .tracking(-0.3)
                .padding(.horizontal, 14)
                .padding(.vertical, 7)
                .frame(height: 34)
                .background(selectedClothesTypes.wrappedValue.contains(label) ? Color.black : Color.gray)
                .foregroundColor(selectedClothesTypes.wrappedValue.contains(label) ? Color.white : Color.black)
                .cornerRadius(18)
        }
    }
}
