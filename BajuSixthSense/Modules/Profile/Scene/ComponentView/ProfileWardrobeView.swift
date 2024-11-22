//
//  ProfileWardrobeView.swift
//  ProfileBajuSixthSense_1
//
//  Created by PadilKeren on 07/11/24.
//

import SwiftUI
import RiveRuntime

struct ProfileWardrobeView: View {
    var columnLayout: [GridItem] = Array(repeating: GridItem(.fixed(0), spacing: 188, alignment: .center), count: 2)
    @Binding var isSheetPresented: Bool
    @Binding var selectedCloth: ClothEntity
    @Binding var clothes: [ClothEntity]
    @State private var isFavorite = false
    
    @Binding var showSelection: Bool
    var variantType: UserVariantType
    var user: ClothOwner
    @ObservedObject var wardrobeVM: WardrobeViewModel
    @ObservedObject var cartVM = ClothCartViewModel.shared
    
    var body: some View {
        ScrollView {
            if(wardrobeVM.finishLoadingWardrobe && wardrobeVM.wardrobeItems.count > 0){
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
                                                try cartVM.updateCatalogCart(owner: user, cloth: cloth)
                                            } catch {
                                                print("Failed adding to cart")
                                            }
                                        },
                                        cartVM: cartVM
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
                        .sheet(isPresented: $cartVM.isSheetPresented) {
                            NewUserCartSheetView(isPresented: $cartVM.isSheetPresented)
                                .presentationDetents([.height(399)])
                        }
                        .padding(.horizontal, 2)
                    }
                    .sheet(isPresented: $isSheetPresented) {
                        DetailCardView(
                            isSheetPresented: $isSheetPresented,
                            cloth: selectedCloth,
                            variantType: variantType == .penerima ? .selection : .edit,
                            descType: .descON,
                            addToCart: {
                                do {
                                    try cartVM.updateCatalogCart(owner: user, cloth: selectedCloth)
                                    print("cart count: \(cartVM.catalogCart.clothItems.count)")
                                } catch {
                                    print("Failed adding to cart")
                                }
                            }
                        )
                            .presentationDetents([.fraction(0.8), .large])
                    }
                }
            } else if(wardrobeVM.finishLoadingWardrobe && wardrobeVM.wardrobeItems.count == 0){
                Image("EmptyWardrobeIllus")
                    .frame(width: 175, height: 127)
                    .padding(.top, 36)
                
                Text("Lemarimu Masih Kosong")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text("Tambah baju kali ya?")
                    .foregroundStyle(.labelSecondary)
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
//    ProfileWardrobeView(showSelection: $showSelection, VariantType: .penerima)
//}
