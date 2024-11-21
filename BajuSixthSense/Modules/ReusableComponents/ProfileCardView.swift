//
//  CatalogCardView.swift
//  ProfileBajuSixthSense_1
//
//  Created by PadilKeren on 07/11/24.
//

import SwiftUI

enum ProfileVariantType {
    case catalogPage
    case cartPage
}

struct ProfileCardView: View {
    @State private var isSheetPresented = false
    @State var selectedCloth: ClothEntity?
    @Binding var isFavorite: Bool
    
    var variantType: ProfileVariantType
    var catalogItem: CatalogDisplayEntity
    var user: ClothOwner
    
    @EnvironmentObject private var navigationRouter: NavigationRouter
    @ObservedObject var cartVM = ClothCartViewModel.shared
    
    var body: some View {
        Rectangle()
            .frame(width: 360, height: 315)
            .foregroundStyle(.systemPureWhite)
            .cornerRadius(6)
            .overlay(
                VStack {
                    HStack {
                        Text(catalogItem.owner.username.first?.uppercased() ?? "?")
                            .font(.title)
                            .foregroundStyle(.white)
                            .padding(18)
                            .background(
                                Circle()
                                    .foregroundStyle(.systemBlack)
                            )
                        
                        VStack(alignment: .leading) {
                            Text(catalogItem.owner.username)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundStyle(.labelPrimary)
                            HStack {
                                Image(systemName: "location.fill")
                                    .font(.system(size: 13))
                                    .foregroundStyle(.labelSecondary)
                                    .padding(.trailing, -5)
                                Text("\(Int(ceil(catalogItem.distance ?? 0))) km")
                                    .font(.footnote)
                                    .fontWeight(.regular)
                                    .foregroundStyle(.labelSecondary)
                            }
                        }
                        Spacer()
                        
                        switch variantType {
                        case .catalogPage:
                            Text(catalogItem.generatePriceRange())
                                .font(.subheadline)
                                .foregroundStyle(.labelSecondary)
                                
                        case .cartPage:
                            Button {
                                navigationRouter.push(to: .ClothCart)
                            } label: {
                                Rectangle()
                                    .frame(width: 47, height: 30)
                                    .foregroundStyle(.systemBlack)
                                    .cornerRadius(6)
                                    .overlay(
                                        Image(systemName: "basket.fill")
                                            .foregroundStyle(.systemPureWhite)
                                    )
                            }
                        }
                    }
                    .padding(.top, 24)
                    .padding(.horizontal, 16)
                    
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(catalogItem.clothes) { cloth in
                                Button {
                                    selectedCloth = cloth
                                    print("this is selected cloth: \(selectedCloth?.id)")
                                    isSheetPresented = true
                                } label: {
                                    AllCardView(
                                        variantType: .catalogMiniPage,
                                        clothEntity: cloth,
                                        editClothStatus: {},
                                        addToCart: {},
                                        cartVM: cartVM
                                    )
                                    .padding(.horizontal, 2)
                                }
                            }
                            .sheet(isPresented: $isSheetPresented) {
                                DetailCardView(
                                    isSheetPresented: $isSheetPresented,
                                    cloth: selectedCloth ?? ClothEntity(),
                                    variantType: .selection,
                                    descType: .descON,
                                    addToCart: {
                                        do {
//                                            print("selected cloth: \(selectedCloth?.id)")
                                            try cartVM.updateCatalogCart(owner: user, cloth: selectedCloth ?? ClothEntity())
                                            print("cart count: \(cartVM.catalogCart.clothItems.count)")
                                        } catch {
                                            print("Failed adding to cart")
                                        }
                                    }
                                )
                                    .presentationDetents([.fraction(0.8), .large])
                            }
                            .sheet(isPresented: $cartVM.isSheetPresented) {
                                NewUserCartSheetView(isPresented: $cartVM.isSheetPresented)
                                    .presentationDetents([.height(399)])
                            }
                            .onChange(of: self.selectedCloth) { oldValue, newValue in
                                print("Ping")
                            }
                        }
                        .frame(height: 233)
                        .padding(.leading, 16)
                    }
                    .padding(.bottom, 24)
                    .scrollIndicators(.hidden)
                }
            )
            .clipShape(RoundedRectangle(cornerRadius: 6))
            .shadow(color: Color.black.opacity(0.04), radius: 4, x: 0, y: 0)
            .shadow(color: Color.black.opacity(0.06), radius: 8, x: 4, y: 2)
            .onChange(of: selectedCloth) { oldValue, newValue in
//                print(selectedCloth?.id ?? "Help me")
            }
    }
}

//#Preview {
//    ProfileCardView(VariantType: .catalogPage)
//}

//finished
