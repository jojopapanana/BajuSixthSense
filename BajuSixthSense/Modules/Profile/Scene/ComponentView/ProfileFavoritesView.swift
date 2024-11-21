//
//  ProfleBookmarkView.swift
//  BajuSixthSense
//
//  Created by Jovanna Melissa on 11/10/24.
//

import SwiftUI
import RiveRuntime

struct ProfileFavoritesView: View {
    @EnvironmentObject var navigationRouter: NavigationRouter
    @ObservedObject var favoriteVM = FavoriteViewModel()
    @ObservedObject var cartVM = ClothCartViewModel.shared
    @State private var isFavorite = true
    
    var body: some View {
        ScrollView {
            if(!(favoriteVM.favoriteCatalogs == .Initial) && favoriteVM.favoriteCatalogs.value?.count ?? 0 > 0){
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
                    .padding(.top, 4)
                }
            } else if(!(favoriteVM.favoriteCatalogs == .Initial) && favoriteVM.favoriteCatalogs.value?.count ?? 0 == 0){
                Text("Ups, kamu belum ada favorite")
            } else {
                VStack{
                    Spacer()
                    RiveViewModel(fileName: "shellyloading-4").view()
                        .frame(width: 200, height: 200)
                    Spacer()
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}

//#Preview {
//    ProfileBookmarkView()
//}
