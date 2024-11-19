//
//  ProfileWardrobeView.swift
//  ProfileBajuSixthSense_1
//
//  Created by PadilKeren on 07/11/24.
//

import SwiftUI

struct ProfileWardrobeView: View {
    var columnLayout: [GridItem] = Array(repeating: GridItem(.fixed(0), spacing: 188, alignment: .center), count: 2)
    @Binding var isSheetPresented: Bool
    @Binding var selectedCloth: ClothEntity
    @Binding var clothes: [ClothEntity]
    
    @Binding var showSelection: Bool
    var variantType: UserVariantType
    @ObservedObject var wardrobeVM: WardrobeViewModel
    @ObservedObject var cartVM = ClothCartViewModel()
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columnLayout, spacing: 16) {
                ForEach(wardrobeVM.wardrobeItems, id: \.self) { cloth in
                    Button {
                        selectedCloth = cloth
                        isSheetPresented = true
                    } label: {
                        switch variantType {
                            case .penerima:
                                AllCardView(
                                    variantType: .cartPage,
                                    clothEntity: cloth,
                                    editClothStatus: {},
                                    addToCart: {
                                        do {
                                            try cartVM.updateCatalogCart(cloth: cloth)
                                        } catch {
                                            print("Failed adding to cart")
                                        }
                                    }
                                )
                                
                            case .pemberi:
                                if (showSelection) {
                                    AllCardView(
                                        variantType: .editPage,
                                        clothEntity: cloth,
                                        editClothStatus: {
                                            clothes.append(cloth)
                                        },
                                        addToCart: {}
                                    )
                                } else {
                                    AllCardView(
                                        variantType: .wardrobePage,
                                        clothEntity: cloth,
                                        editClothStatus: {},
                                        addToCart: {}
                                    )
                                }
                            }
                    }
                    .padding(.horizontal, 2)
                }
                .sheet(isPresented: $isSheetPresented) {
                    DetailCardView(cloth: selectedCloth, variantType: .edit, descType: .descON)
                        .presentationDetents([.fraction(0.8), .large])
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}

//#Preview {
//    ProfileWardrobeView(showSelection: $showSelection, VariantType: .penerima)
//}
