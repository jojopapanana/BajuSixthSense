//
//  ProfleBookmarkView.swift
//  BajuSixthSense
//
//  Created by Jovanna Melissa on 11/10/24.
//

import SwiftUI

struct ProfileFavoritesView: View {
    @EnvironmentObject var navigationRouter: NavigationRouter
    @ObservedObject var favoriteVM = FavoriteViewModel()
    
    var body: some View {
        ScrollView {
            ForEach(
                favoriteVM.favoriteCatalogs.value ?? [CatalogDisplayEntity]()
            ) { item in
                ProfileCardView(
                    variantType: .cartPage,
                    catalogItem: item
                )
                    .padding(.horizontal, 2)
            }
        }
        .scrollIndicators(.hidden)
    }
}

//#Preview {
//    ProfileBookmarkView()
//}
