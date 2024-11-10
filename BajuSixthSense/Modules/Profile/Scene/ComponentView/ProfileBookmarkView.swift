//
//  ProfleBookmarkView.swift
//  BajuSixthSense
//
//  Created by Jovanna Melissa on 11/10/24.
//

import SwiftUI

//struct ProfileBookmarkView: View {
//    var columnLayout: [GridItem] = Array(repeating: GridItem(.fixed(161), spacing: 36, alignment: .center), count: 2)
//    var catalogItems: [CatalogItemEntity]?
//    @State var bookmarkItems: [CatalogItemEntity] = []
//    
//    @ObservedObject var bookmarkVM = BookmarkViewModel()
//    @ObservedObject var catalogVM = CatalogViewModel()
//    @EnvironmentObject var navigationRouter: NavigationRouter
//    
//    var body: some View {
//        if bookmarkVM.bookmarkedItems.isEmpty && catalogItems == nil {
//            VStack {
//                Text("Your bookmarks will appear here!")
//                    .font(.subheadline)
//                    .foregroundStyle(.systemGrey1)
//                
//                Text("Start saving your favorite items to")
//                    .font(.subheadline)
//                    .foregroundStyle(.systemGrey1)
//                
//                Text("easily find them later.")
//                    .font(.subheadline)
//                    .foregroundStyle(.systemGrey1)
//            }
//            .padding(.top, 250)
//        } else {
//            ScrollView {
//                LazyVGrid(columns: columnLayout, spacing: 36) {
//                    ForEach(
//                        catalogItems ?? bookmarkItems
//                    ) { item in
//                        ClothesCardView(
//                            bulk: item,
//                            catalogVM: catalogVM,
//                            bookmarkVM: bookmarkVM
//                        )
//                        .onTapGesture {
//                            navigationRouter.push(to: .ProductDetail(bulk: item, isOwner: CatalogViewModel.checkIsOwner(ownerId: item.owner.id)))
//                        }
//                    }
//                }
//                .onAppear {
//                    bookmarkItems = bookmarkVM.bookmarkedItems
//                }
//                .onChange(of: bookmarkVM.bookmarkedItems) { oldValue, newValue in
//                    bookmarkItems = newValue
//                }
//            }
//        }
//    }
//}

//#Preview {
//    ProfileBookmarkView()
//}
