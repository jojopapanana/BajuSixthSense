//
//  ProfleBookmarkView.swift
//  BajuSixthSense
//
//  Created by Jovanna Melissa on 11/10/24.
//

import SwiftUI

struct ProfileBookmarkView: View {
    var clothesCount = 3
    
    var body: some View {
        if clothesCount == 0{
            VStack {
                Text("Your bookmarks will appear here!")
                    .font(.subheadline)
                    .foregroundStyle(.systemGrey1)
                Text("Start saving your favorite items to")
                    .font(.subheadline)
                    .foregroundStyle(.systemGrey1)
                Text("easily find them later.")
                    .font(.subheadline)
                    .foregroundStyle(.systemGrey1)
            }
            .padding(.top, 250)
        } else {
            VStack(spacing: 36) {
                ForEach(0..<clothesCount / 2 + 1, id: \.self) { rowIndex in
                    HStack(spacing: 24) {
                        ForEach(0..<2, id: \.self) { columnIndex in
                            let cardIndex = rowIndex * 2 + columnIndex
                            if cardIndex < clothesCount{
                                #warning("TO-DO: make navigation link to clothes' details")
                                if clothesCount % 2 != 0 && cardIndex == clothesCount - 1{
                                    ClothesCardView(numberofClothes: 10, bookmarkClicked: true)
                                        .padding(.leading, 4)
                                    Spacer()
                                } else {
                                    ClothesCardView(numberofClothes: 10, bookmarkClicked: true)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}

#Preview {
    ProfileBookmarkView()
}
