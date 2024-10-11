//
//  ProfleBookmarkView.swift
//  BajuSixthSense
//
//  Created by Jovanna Melissa on 11/10/24.
//

import SwiftUI

struct ProfileBookmarkView: View {
    var clothesCount = 9
    
    var body: some View {
            VStack(spacing: 36) {
                ForEach(0..<clothesCount / 2 + 1, id: \.self) { rowIndex in
                    HStack(spacing: 36) {
                        ForEach(0..<2, id: \.self) { columnIndex in
                            let cardIndex = rowIndex * 2 + columnIndex
                            if cardIndex < clothesCount{
                                ClothesCardView(numberofClothes: 10)
                                
                                if clothesCount % 2 != 0 && cardIndex == clothesCount - 1{
                                    Spacer()
                                }
                            }
                        }
                    }
                }
            }
        .padding()
    }
}

#Preview {
    ProfileBookmarkView()
}
