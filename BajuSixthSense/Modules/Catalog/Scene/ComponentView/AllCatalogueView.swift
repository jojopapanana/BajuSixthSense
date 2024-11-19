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
    
    @Binding var isFilterSheetShowed: Bool
    
    var body: some View {
<<<<<<< HEAD
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
        .padding(.top, 15)
        
        ForEach(filteredItem) { item in
            ProfileCardView(VariantType: .catalogPage, catalogItem: item)
=======
        ForEach(catalogVM.displayCatalogItems.value ?? [CatalogDisplayEntity]()) { item in
            Button {
                navigationRouter.push(to: .Profile(userID: item.owner.userID))
            } label: {
                ProfileCardView(variantType: .catalogPage, catalogItem: item)
            }
>>>>>>> development
        }
    }
}

//#Preview {
//    AllCatalogueView(clothesCount: 3)
//}
