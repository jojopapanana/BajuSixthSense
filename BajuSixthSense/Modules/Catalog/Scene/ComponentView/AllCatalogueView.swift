//
//  AllCatalogueView.swift
//  BajuSixthSense
//
//  Created by Jovanna Melissa on 15/10/24.
//

import SwiftUI

struct AllCatalogueView: View {
    var filteredClothes: [CatalogItemEntity]
    
    var body: some View {
        VStack(spacing: 36) {
            ForEach(0..<filteredClothes.count / 2 + 1, id: \.self) { rowIndex in
                HStack(spacing: 24) {
                    ForEach(0..<2, id: \.self) { columnIndex in
                        let cardIndex = rowIndex * 2 + columnIndex
                        if cardIndex < filteredClothes.count{
                            if filteredClothes.count % 2 != 0 && cardIndex == filteredClothes.count - 1{
                                NavigationLink{
                                    CatalogDetailView(bulk: filteredClothes[cardIndex], isOwner: false)
                                } label: {
                                    ClothesCardView(bookmarkClicked: false, bulk: filteredClothes[cardIndex])
                                        .padding(.leading, 4)
                                }
                                Spacer()
                            } else {
                                NavigationLink{
                                    CatalogDetailView(bulk: filteredClothes[cardIndex], isOwner: false)
                                } label: {
                                    ClothesCardView(bookmarkClicked: false, bulk: filteredClothes[cardIndex])
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

//#Preview {
//    AllCatalogueView(clothesCount: 3)
//}
