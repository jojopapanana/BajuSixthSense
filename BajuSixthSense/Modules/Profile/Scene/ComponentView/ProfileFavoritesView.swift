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
                    Button{
                        navigationRouter.push(to: .Profile(userID: item.owner.userID ?? ""))
                    } label: {
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
                }
            } else if(!(favoriteVM.favoriteCatalogs == .Initial) && favoriteVM.favoriteCatalogs.value?.count ?? 0 == 0){
                Image("EmptyFavoritesIllus")
                    .frame(width: 175, height: 127)
                    .padding(.top, 36)
                
                Text("Belum Ada Pakaian Favorit")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text("Yakin gak ada baju yang kamu suka?\nPilih aja baju yang kamu suka, nanti kelomang tambahin disini")
                    .foregroundStyle(.labelSecondary)
                    .multilineTextAlignment(.center)
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
