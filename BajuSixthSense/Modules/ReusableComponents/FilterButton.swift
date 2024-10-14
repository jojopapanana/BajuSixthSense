//
//  FilterButton.swift
//  BajuSixthSense
//
//  Created by PadilKeren on 13/10/24.
//

import SwiftUI

struct FilterButton: View {
    let label: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(label)
                .font(.system(size: 15))
                .tracking(-0.3)
                .padding(.horizontal, 14)
                .padding(.vertical, 7)
                .frame(height: 34)
                .background(isSelected ? Color.black : Color.gray.opacity(0.2))
                .foregroundColor(isSelected ? Color.white : Color.black)
                .cornerRadius(18)
        }
    }
}
