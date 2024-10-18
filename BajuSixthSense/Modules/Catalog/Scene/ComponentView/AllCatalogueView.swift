//
//  AllCatalogueView.swift
//  BajuSixthSense
//
//  Created by Jovanna Melissa on 15/10/24.
//

import SwiftUI

struct AllCatalogueView: View {
    var columnLayout: [GridItem] = Array(repeating: GridItem(.fixed(161), spacing: 36, alignment: .center), count: 2)
    var filteredClothes: [CatalogItemEntity]
    
    @ObservedObject var bookmarkVM = BookmarkViewModel()
    @ObservedObject var catalogVM: CatalogViewModel
    
    var body: some View {
        LazyVGrid(columns: columnLayout) {
            ForEach(filteredClothes) { item in
                NavigationLink{
                    CatalogDetailView(
                        bulk: item,
                        catalogVM: catalogVM
                    )
                } label: {
                    ClothesCardView(
                        bookmarkClicked: bookmarkVM.checkIsBookmark(catalogItem: item),
                        bulk: item,
                        catalogVM: catalogVM
                    )
                        .padding(.leading, 4)
                }
            }
        }
    }
}

//#Preview {
//    AllCatalogueView(clothesCount: 3)
//}
