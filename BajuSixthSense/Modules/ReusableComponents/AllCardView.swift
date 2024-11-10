//
//  AllCardView.swift
//  BajuSixthSense
//
//  Created by PadilKeren on 07/11/24.
//

import SwiftUI

// NOTE
// gimana caranya kalo pilih +Tambah di case .cartPage nanti di profil ada text "3 item, tambahkan lagi bajumu bla-bla-bla. 

//class SharedState: ObservableObject {
//    @Published var cartSelected: Bool = false
//}

struct AllCardView: View {
    @State var bookmarkClicked: Bool = false
    @State var editSelected: Bool = false
    @State var cartSelected: Bool = false
//    @State var sharedState: SharedState
    
    enum VariantType {
        case wardrobePage
        case catalogPage
        case catalogMiniPage
        case cartPage
        case editPage
    }
    
    var variantType: VariantType
    
    private var rectangleHeight: CGFloat {
            switch variantType {
            case .wardrobePage:
                return 270
            case .catalogPage:
                return 242
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
        case .catalogPage:
            return 174
        default:
            return 172
        }
    }
    
    var body: some View {
        Rectangle()
            .frame(width: rectangleWeight, height: rectangleHeight)
            .foregroundStyle(.systemBackground)
            .overlay(
                VStack {
                    ZStack {
                        switch variantType {
                        case .catalogMiniPage:
                            Image("Image")
                                .resizable()
                                .frame(width: 141, height: 141)
                                .aspectRatio(contentMode: .fill) // cek lagi aspect rationya yak gua masih ngasal hehe
                        case .catalogPage:
                            Image("Image")
                                .resizable()
                                .frame(width: 174, height: 174)
                                .aspectRatio(contentMode: .fill) // cek lagi aspect rationya yak gua masih ngasal hehe
                        default:
                            Image("Image")
                                .resizable()
                                .frame(width: 172, height: 172)
                                .aspectRatio(contentMode: .fill) // cek lagi aspect rationya yak gua masih ngasal hehe
                        }
                        
                        VStack {
                            HStack {
                                Spacer()
                                
                                switch variantType {
                                case .catalogPage, .catalogMiniPage, .cartPage:
                                    Button {
                                        bookmarkClicked.toggle() // logic bookmark
                                    } label: {
                                        ZStack {
                                            Circle()
                                                .fill(Color.white)
                                                .frame(width: 30, height: 30)
                                            Image(systemName: "circle")
                                                .font(.system(size: 32))
                                                .fontWeight(.ultraLight)
                                            
                                            if !bookmarkClicked{
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
                                        editSelected.toggle() // logic selectedEdit
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
                                Text("Kemeja") // vm type
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.labelPrimary)
                                
                                Text("Lubang • Noda • +2") // vm defect
                                    .font(.caption)
                                    .foregroundStyle(.labelSecondary)
                                    .padding(.bottom, 8)
                                
                                Text("Rp 8.000") // vm harga
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.labelPrimary)
                                    .padding(.bottom, 8)
                                
                                switch variantType {
                                case .catalogPage, .catalogMiniPage:
                                    Spacer()
                                    
                                case .cartPage:
                                    Button {
//                                        Toggle("Select Cart", isOn: $sharedState.cartSelected)
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
//                                                    if sharedState.cartSelected {
                                                    if !cartSelected {
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
                                    Text("Diposting") // vm status
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
                                        // logic edit detail clothes
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
                    if variantType == .cartPage && /*sharedState.*/cartSelected {
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
    }
}

#Preview {
    AllCardView(variantType: .editPage)
}
