//
//  FilterButton.swift
//  BajuSixthSense
//
//  Created by PadilKeren on 13/10/24.
//

import SwiftUI

struct FilterButton: View {
    let label: ClothType
    @State var isSelected = false
    @Binding var selectedFilters: Set<ClothType>
    
    var body: some View {
        Button{
            if selectedFilters.contains(label) {
                selectedFilters.remove(label)
            } else {
                selectedFilters.insert(label)
            }
            isSelected.toggle()
        } label: {
            Text(label.rawValue)
                .font(.body)
                .padding(.horizontal, 14)
                .padding(.vertical, 7)
                .frame(height: 34)
                .background(isSelected ? Color.black : Color.gray.opacity(0.2))
                .foregroundColor(isSelected ? Color.white : Color.black)
                .cornerRadius(18)
        }
    }
}
