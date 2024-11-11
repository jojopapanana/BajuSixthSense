//
//  CatalogCardView.swift
//  ProfileBajuSixthSense_1
//
//  Created by PadilKeren on 07/11/24.
//

import SwiftUI

struct ProfileCardView: View {
    @State private var isSheetPresented = false
    @State var selectedCloth: ClothEntity?
    
    enum variantType {
        case catalogPage
        case cartPage
    }
    
    var VariantType: variantType
    var catalogItem: CatalogItemEntity
    
    var body: some View {
        Rectangle()
            .frame(width: 360, height: 315)
            .foregroundStyle(.systemPureWhite)
            .cornerRadius(6)
            .overlay(
                VStack {
                    HStack {
                        Circle() // profile picture
                            .frame(width: 38, height: 38)
                        
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
                                Text("\(catalogItem.distance ?? 0) km")
                                    .font(.footnote)
                                    .fontWeight(.regular)
                                    .foregroundStyle(.labelSecondary)
                            }
                        }
                        Spacer()
                        
                        switch VariantType {
                        case .catalogPage:
                            Text("Rp0 - Rp50k")
                                .font(.subheadline)
                                .foregroundStyle(.labelSecondary)
                                #warning("TO-DO: Replace price number with price variables")
                                
                        case .cartPage:
                            Button {
                                #warning("TO-DO: Navigate to cart page")
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
                    .padding(.top, 16)
                    .padding(.horizontal, 16)
                    
                    #warning("TO-DO: Please uncomment once the domain and data layer are added because this one needs them :(")
//                    ScrollView(.horizontal) {
//                        HStack {
//                            ForEach(catalogItem.clothes) { cloth in
//                                Button {
//                                    selectedCloth = cloth
//                                    isSheetPresented = true
//                                } label: {
//                                    AllCardView(variantType: .catalogMiniPage)
//                                        .padding(.horizontal, 2)
//                                }
//                            }
//                            .sheet(isPresented: $isSheetPresented) {
//                                DetailCardView(cloth: selectedCloth, variantType: .selection, descType: .descON)
//                                    .presentationDetents([.fraction(0.8), .large])
//                            }
//                        }
//                        .frame(height: 233)
//                        .padding(.leading, 16)
//                    }
//                    .scrollIndicators(.hidden)
                }
            )
            .clipShape(RoundedRectangle(cornerRadius: 6))
            .shadow(color: Color.black.opacity(0.04), radius: 4, x: 0, y: 0)
            .shadow(color: Color.black.opacity(0.06), radius: 8, x: 4, y: 2)
    }
}

//#Preview {
//    ProfileCardView(VariantType: .catalogPage)
//}

//finished
