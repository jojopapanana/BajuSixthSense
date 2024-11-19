//
//  AllCatalogueView.swift
//  BajuSixthSense
//
//  Created by Jovanna Melissa on 15/10/24.
//

import SwiftUI

struct AllCatalogueView: View {
    @EnvironmentObject var navigationRouter: NavigationRouter
    @ObservedObject var catalogVM: CatalogViewModel
    
    var body: some View {
        ForEach(catalogVM.displayCatalogItems.value ?? [CatalogDisplayEntity]()) { item in
            Button {
                navigationRouter.push(to: .Profile(userID: item.owner.userID))
            } label: {
                ProfileCardView(variantType: .catalogPage, catalogItem: item)
            }
        }
    }
}

//#Preview {
//    AllCatalogueView(clothesCount: 3)
//}
