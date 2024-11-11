//
//  AllCatalogueView.swift
//  BajuSixthSense
//
//  Created by Jovanna Melissa on 15/10/24.
//

import SwiftUI

struct AllCatalogueView: View {
//    var columnLayout: [GridItem] = Array(repeating: GridItem(.fixed(161), spacing: 36, alignment: .center), count: 2)
    var filteredItem: [CatalogItemEntity]
    
    @EnvironmentObject var navigationRouter: NavigationRouter
    @ObservedObject var bookmarkVM = BookmarkViewModel()
    @ObservedObject var catalogVM: CatalogViewModel
    
    var body: some View {
        ForEach(filteredItem) { item in
            ProfileCardView(VariantType: .catalogPage, catalogItem: item)
        }
    }
}

//#Preview {
//    AllCatalogueView(clothesCount: 3)
//}
