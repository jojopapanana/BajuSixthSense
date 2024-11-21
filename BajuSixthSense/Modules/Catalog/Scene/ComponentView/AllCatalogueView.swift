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
    @Binding var isFilterSheetShowed: Bool
    
    var body: some View {
        Button{
            isFilterSheetShowed = true
        } label: {
            ZStack{
                RoundedRectangle(cornerRadius: 6)
                    .fill(.systemPureWhite)
                    .shadow(color: Color.black.opacity(0.04), radius: 4, x: 0, y: 0)
                    .shadow(color: Color.black.opacity(0.06), radius: 8, x: 4, y: 2)
                
                HStack{
                    VStack(alignment: .leading){
                        Text("Filter Harga")
                            .font(.subheadline)
                            .foregroundStyle(.systemBlack)
                        
                        Text("Sesuaikan dengan budget mu")
                            .font(.footnote)
                            .foregroundStyle(.labelSecondary)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "slider.horizontal.3")
                        .foregroundStyle(.systemBlack)
                        .font(.system(size: 20))
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
            }
            .padding(.horizontal, 16)
        }
        .padding(.top, 2)
        
        LazyVStack{
            ForEach(catalogVM.displayCatalogItems.value ?? [CatalogDisplayEntity]()) { item in
                Button {
                    navigationRouter.push(to: .Profile(userID: item.owner.userID))
                } label: {
                    ProfileCardView(isFavorite: $isFavorite, variantType: .catalogPage, catalogItem: item, user: ClothOwner(userID: item.owner.userID ?? "", username: item.owner.username, contact: item.owner.contactInfo, latitude: item.owner.coordinate.lat, longitude: item.owner.coordinate.lon, sugestedAmount: item.owner.sugestedMinimal), cartVM: cartVM)
                        .padding(.bottom, 12)
                }
                .padding(0)
            }
        }
        .padding(.top, -8)
        .padding(.bottom, 24)
    }
}

//#Preview {
//    AllCatalogueView(clothesCount: 3)
//}
