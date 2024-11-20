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
    @ObservedObject var cartVM = ClothCartViewModel.shared
    @State private var isFavorite = true
    
    var body: some View {
        ScrollView {
            ForEach(
                favoriteVM.favoriteCatalogs.value ?? [CatalogDisplayEntity]()
            ) { item in
                ProfileCardView(
                    isFavorite: $isFavorite, variantType: .cartPage,
                    catalogItem: item,
                    user: ClothOwner(userID: item.owner.userID ?? "", username: item.owner.username, contact: item.owner.contactInfo, latitude: item.owner.coordinate.lat, longitude: item.owner.coordinate.lon, sugestedAmount: item.owner.sugestedMinimal),
                    cartVM: cartVM
                )
                .padding(.horizontal, 2)
                .padding(.bottom, 12)
            }
        }
        .scrollIndicators(.hidden)
    }
}

//#Preview {
//    ProfileBookmarkView()
//}
