//
//  AllCatalogueView.swift
//  BajuSixthSense
//
//  Created by Jovanna Melissa on 15/10/24.
//

import SwiftUI

//struct AllCatalogueView: View {
//    var columnLayout: [GridItem] = Array(repeating: GridItem(.fixed(161), spacing: 36, alignment: .center), count: 2)
//    var filteredClothes: [CatalogItemEntity]
//    
//    @EnvironmentObject var navigationRouter: NavigationRouter
//    @ObservedObject var bookmarkVM = BookmarkViewModel()
//    @ObservedObject var catalogVM: CatalogViewModel
//    
//    var body: some View {
//        LazyVGrid(columns: columnLayout, spacing: 36) {
//            ForEach(filteredClothes) { item in
//                Button {
//                    navigationRouter.push(to: .ProductDetail(bulk: item, isOwner: CatalogViewModel.checkIsOwner(ownerId: item.owner.id)))
//                } label: {
//                    ClothesCardView(
//                        bulk: item,
//                        bookmarkVM: bookmarkVM
//                    )
//                        .padding(.leading, 4)
//                }
//            }
//        }
//    }
//}

//#Preview {
//    AllCatalogueView(clothesCount: 3)
//}
