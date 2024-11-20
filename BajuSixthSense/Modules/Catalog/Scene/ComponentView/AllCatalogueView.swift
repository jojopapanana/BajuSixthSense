//
//  AllCatalogueView.swift
//  BajuSixthSense
//
//  Created by Jovanna Melissa on 15/10/24.
//

import SwiftUI

struct AllCatalogueView: View {
    @State private var isFavorite = false
    
    @EnvironmentObject var navigationRouter: NavigationRouter
    @ObservedObject var catalogVM: CatalogViewModel
    @ObservedObject var cartVM = ClothCartViewModel.shared
    
    var body: some View {
        ForEach(catalogVM.displayCatalogItems.value ?? [CatalogDisplayEntity]()) { item in
            Button {
                navigationRouter.push(to: .Profile(userID: item.owner.userID))
            } label: {
                ProfileCardView(isFavorite: $isFavorite, variantType: .catalogPage, catalogItem: item, user: ClothOwner(userID: item.owner.userID ?? "", username: item.owner.username, contact: item.owner.contactInfo, latitude: item.owner.coordinate.lat, longitude: item.owner.coordinate.lon, sugestedAmount: item.owner.sugestedMinimal), cartVM: cartVM)
            }
        }
    }
}

//#Preview {
//    AllCatalogueView(clothesCount: 3)
//}
