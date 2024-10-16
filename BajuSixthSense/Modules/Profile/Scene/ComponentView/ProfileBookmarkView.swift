//
//  ProfleBookmarkView.swift
//  BajuSixthSense
//
//  Created by Jovanna Melissa on 11/10/24.
//

import SwiftUI

struct ProfileBookmarkView: View {
//    var clothesCount = 3
    var bulks: [CatalogItemEntity]
    
    var body: some View {
        if bulks.count == 0 {
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
                ForEach(0..<bulks.count / 2 + 1, id: \.self) { rowIndex in
                    HStack(spacing: 24) {
                        ForEach(0..<2, id: \.self) { columnIndex in
                            let cardIndex = rowIndex * 2 + columnIndex
                            if cardIndex < bulks.count{
                                #warning("TO-DO: make navigation link to clothes' details")
                                if bulks.count % 2 != 0 && cardIndex == bulks.count - 1{
                                    ClothesCardView(bookmarkClicked: true, bulk: bulks[cardIndex])
                                        .padding(.leading, 4)
                                    Spacer()
                                } else {
                                    ClothesCardView(bookmarkClicked: true, bulk: bulks[cardIndex])
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

//#Preview {
//    ProfileBookmarkView()
//}
