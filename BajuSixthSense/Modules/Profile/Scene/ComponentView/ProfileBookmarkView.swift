//
//  ProfleBookmarkView.swift
//  BajuSixthSense
//
//  Created by Jovanna Melissa on 11/10/24.
//

import SwiftUI

struct ProfileBookmarkView: View {
//    var columnLayout: [GridItem] = Array(repeating: GridItem(.fixed(161), spacing: 36, alignment: .center), count: 2)
//    var catalogItems: [CatalogItemEntity]?
//    @State var bookmarkItems: [CatalogItemEntity] = []
//    
//    @ObservedObject var bookmarkVM = BookmarkViewModel()
//    @ObservedObject var catalogVM = CatalogViewModel()
//    @EnvironmentObject var navigationRouter: NavigationRouter
    
    var body: some View {
        ScrollView {
            ForEach(0...5, id: \.self) { _ in
                ProfileCardView(VariantType: .cartPage)
                    .padding(.horizontal, 2)
            }
        }
        .scrollIndicators(.hidden)
    }
}

//#Preview {
//    ProfileBookmarkView()
//}
