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
                .font(.custom("Montserrat-SemiBold", size: 20))
                .padding(.horizontal)
            
            Text("What type of clothes are included in your clothes bulk?")
                .padding(.horizontal)
                .font(.system(size: 14))
                .tracking(-0.4)
                .foregroundStyle(Color.gray)
                .lineLimit(1)
            
            Rectangle()
                .frame(width: 350, height: 1)
                .foregroundStyle(Color.gray)
                .padding(.horizontal)
                .padding(.bottom, 15)
            
            WrappedHStack() {
                ForEach(options1, id: \.self) { option in
                    selectedTypeButton(label: option, selectedClothesTypes: $selectedClothesType)
                }
            }
            .padding(.horizontal)
            
//            HStack {
//                selectedTypeButton(label: "Shirt", selectedClothesTypes: $selectedClothesType)
//                selectedTypeButton(label: "T-Shirt", selectedClothesTypes: $selectedClothesType)
//                selectedTypeButton(label: "Sweater", selectedClothesTypes: $selectedClothesType)
//                selectedTypeButton(label: "Hoodies", selectedClothesTypes: $selectedClothesType)
//            }
//            .padding(.horizontal)
//            .padding(.bottom, 5)
//            
//            HStack {
//                selectedTypeButton(label: "Long Pants", selectedClothesTypes: $selectedClothesType)
//                selectedTypeButton(label: "Skirt", selectedClothesTypes: $selectedClothesType)
//                selectedTypeButton(label: "Shorts", selectedClothesTypes: $selectedClothesType)
//                selectedTypeButton(label: "Jackets", selectedClothesTypes: $selectedClothesType)
//            }
//            .padding(.horizontal)
            
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
                .padding(.horizontal, 16)
                .frame(height: 34)
                .background(selectedClothesTypes.wrappedValue.contains(label) ? Color.black : Color.gray)
                .foregroundColor(selectedClothesTypes.wrappedValue.contains(label) ? Color.white : Color.black)
                .cornerRadius(18)
        }
    }
}
