//
//  ProfleBookmarkView.swift
//  BajuSixthSense
//
//  Created by Jovanna Melissa on 11/10/24.
//

import SwiftUI

struct ProfileBookmarkView: View {
    var columnLayout: [GridItem] = Array(repeating: GridItem(.fixed(161), spacing: 36, alignment: .center), count: 2)
    var catalogItems: [CatalogItemEntity]?
    
    @ObservedObject var bookmarkVM = BookmarkViewModel()
    @ObservedObject var catalogVM = CatalogViewModel()
    
    
    var body: some View {
        if bookmarkVM.bookmarkedItems.isEmpty {
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
            LazyVGrid(columns: columnLayout) {
                ForEach(
                    catalogItems ?? bookmarkVM.bookmarkedItems
                ) { item in
                    ClothesCardView(
                        bookmarkClicked: bookmarkVM.checkIsBookmark(catalogItem: item),
                        bulk: item,
                        catalogVM: catalogVM
                    )
                    .onTapGesture {
                    #warning("Add navigation routing")
                    }
                }
            }
        }
    }
}

//#Preview {
//    ProfileBookmarkView()
//}
