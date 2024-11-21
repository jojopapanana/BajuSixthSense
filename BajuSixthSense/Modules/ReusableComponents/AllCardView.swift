//
//  AllCardView.swift
//  BajuSixthSense
//
//  Created by PadilKeren on 07/11/24.
//

import SwiftUI

enum VariantType {
    case wardrobePage
    case catalogMiniPage
    case cartPage
    case editPage
}

struct AllCardView: View {
    @State var bookmarkClicked: Bool = false
    @State var editSelected: Bool = false
    @State var cartSelected: Bool = false
    @State var favorites: [String] = []
    
    var variantType: VariantType
    var clothEntity: ClothEntity
    var editClothStatus: () -> Void
    var addToCart: () -> Void
    @State var isFavourite = false
    
    private var rectangleHeight: CGFloat {
        switch variantType {
            case .wardrobePage:
                return 270
            case .catalogMiniPage:
                return 217
            case .cartPage:
                return 290
            case .editPage:
                return 270
        }
    }
    
    private var rectangleWeight: CGFloat {
        switch variantType {
            case .catalogMiniPage:
                return 141
            default:
                return 172
        }
    }
    
    @ObservedObject var cartVM = ClothCartViewModel.shared
    
    @EnvironmentObject private var navigationRouter: NavigationRouter
    
    var body: some View {
        Rectangle()
            .frame(width: rectangleWeight, height: rectangleHeight)
            .foregroundStyle(.systemBackground)
            .overlay(
                VStack {
                    ZStack {
                        switch variantType {
                            case .catalogMiniPage:
                                Image(uiImage: clothEntity.photo ?? UIImage(systemName: "exclamationmark.triangle.fill")!)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 141, height: 141)
                                    .background(Color.backgroundBlack100)
                                
                            default:
                                Image(uiImage: clothEntity.photo ?? UIImage(systemName: "exclamationmark.triangle.fill")!)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 172, height: 172)
                                    .background(Color.backgroundBlack100)
                        }
                        
                        VStack {
                            HStack {
                                Spacer()
                                
                                switch variantType {
                                    case .catalogMiniPage, .cartPage:
                                        Button {
                                            if isFavourite {
                                                CatalogViewModel.removeFavorite(
                                                    owner: clothEntity.owner,
                                                    cloth: clothEntity.id
                                                )
                                            } else {
                                                CatalogViewModel.addFavorite(
                                                    owner: clothEntity.owner,
                                                    cloth: clothEntity.id
                                                )
                                            }
//                                            bookmarkClicked.toggle()
                                            isFavourite.toggle()
                                        } label: {
                                            ZStack {
                                                Circle()
                                                    .fill(Color.white)
                                                    .frame(width: 30, height: 30)
                                                Image(systemName: "circle")
                                                    .font(.system(size: 32))
                                                    .fontWeight(.ultraLight)
                                                
                                                if !isFavourite{
                                                    Image(systemName: "heart")
                                                        .font(.system(size: 16))
                                                } else {
                                                    Image(systemName: "heart.fill")
                                                        .font(.system(size: 16))
                                                }
                                            }
                                            .foregroundStyle(.systemBlack)
                                        }
                                        .padding(.top, 6)
                                        .padding(.trailing, 2)
                                        
                                    case .editPage:
                                        Button {
                                            editClothStatus()
                                            editSelected.toggle()
                                        } label: {
                                            ZStack {
                                            if !editSelected {
                                                Circle()
                                                    .fill(Color.white)
                                                    .frame(width: 30, height: 30)
                                                Image(systemName: "circle")
                                                    .font(.system(size: 32))
                                                    .fontWeight(.ultraLight)
                                                    .foregroundStyle(.systemBlack)
                                            } else {
                                                Circle()
                                                    .fill(.systemBlack)
                                                    .frame(width: 30, height: 30)
                                                Image(systemName: "circle")
                                                    .font(.system(size: 32))
                                                    .fontWeight(.ultraLight)
                                                    .foregroundStyle(.systemBlack)
                                            }
                                                if !editSelected {
                                                    Image(systemName: "")
                                                        .font(.system(size: 16))
                                                } else {
                                                    Image(systemName: "checkmark")
                                                        .font(.system(size: 16))
                                                }
                                            }
                                            .foregroundStyle(.systemPureWhite)
                                        }
                                        .padding(.top, 6)
                                        .padding(.trailing, 2)
                                        
                                    case .wardrobePage:
                                        EmptyView()
                                    }
                            }
                            Spacer()
                        }
                    }
                    Spacer()
                    
                    VStack {
                        HStack {
                            VStack(alignment: .leading, spacing: 0) {
                                Text(clothEntity.generateClothName())
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.labelPrimary)
                                
                                Text(clothEntity.generateDefectsString())
                                    .font(.caption)
                                    .foregroundStyle(.labelSecondary)
                                    .padding(.bottom, 8)
                                
                                Text("Rp \(clothEntity.price)")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.labelPrimary)
                                    .padding(.bottom, 8)
                                
                                switch variantType {
                                    case .catalogMiniPage:
                                        Spacer()
                                        
                                    case .cartPage:
                                        Button {
                                            cartSelected.toggle()
                                            addToCart()
                                        } label: {
                                            Rectangle()
                                                .frame(width: 156, height: 34)
                                                .foregroundStyle(.systemPureWhite)
                                                .cornerRadius(6)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 6)
                                                        .stroke(style: StrokeStyle(lineWidth: 1))
                                                        .foregroundStyle(.systemBlack)
                                                )
                                                .overlay(
                                                    HStack {
                                                        if !(cartVM.catalogCart.clothItems.contains(clothEntity.id ?? "")) {
                                                            Image(systemName: "plus")
                                                            Text("Tambah")
                                                                .font(.system(size: 15, weight: .regular))
                                                        } else {
                                                            Image(systemName: "checkmark")
                                                            Text("Dipilih")
                                                                .font(.system(size: 15, weight: .regular))
                                                        }
                                                    }
                                                        .foregroundStyle(.systemBlack)
                                                )
                                        }
                                        .padding(.bottom, 4)
                                        Spacer()
                                        
                                    case .editPage, .wardrobePage:
                                        Text(clothEntity.status.rawValue)
                                            .font(.caption)
                                            .foregroundStyle(.labelSecondary)
                                        Spacer()
                                }
                            }
                            .padding(.leading, 8)
                            Spacer()
                            
                            switch variantType {
                                case .wardrobePage:
                                    VStack {
                                        Button {
                                            let wardrobeVM = WardrobeViewModel.shared
                                            guard let idx = wardrobeVM.wardrobeItems.firstIndex(of: clothEntity) else { return }
                                            navigationRouter.push(to: .EditClothItem(clothIdx: idx, cloth: clothEntity))
                                        } label: {
                                            Image(systemName: "pencil.circle.fill")
                                                .font(.system(size: 25))
                                                .foregroundStyle(.systemBlack)
                                        }
                                        .padding(.trailing, 8)
                                        Spacer()
                                    }
                                    
                                default:
                                    EmptyView()
                                }
                        }
                    }
                }
            )
            .overlay(
                Group {
                    if variantType == .cartPage && (cartVM.catalogCart.clothItems.contains(clothEntity.id ?? "")) {
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(.systemBlack, lineWidth: 1)
                    } else if variantType == .cartPage {
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(style: StrokeStyle(lineWidth: 0))
                    } else {
                        EmptyView()
                    }
                    
                    if variantType == .editPage && editSelected {
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(.systemBlack, lineWidth: 1)
                    } else if variantType == .editPage {
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(style: StrokeStyle(lineWidth: 0))
                    } else {
                        EmptyView()
                    }
                }
            )
            .clipShape(RoundedRectangle(cornerRadius: 6))
            .shadow(color: Color.black.opacity(0.04), radius: 4, x: 0, y: 0)
            .shadow(color: Color.black.opacity(0.06), radius: 8, x: 4, y: 2)
            .onAppear {
                isFavourite = LocalUserDefaultRepository.shared.fetchFavorite(ownerID: clothEntity.owner).contains(clothEntity.id ?? "")
            }
    }
}

//#Preview {
//    AllCardView(variantType: .editPage)
//}
