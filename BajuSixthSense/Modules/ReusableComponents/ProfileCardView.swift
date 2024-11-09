//
//  CatalogCardView.swift
//  ProfileBajuSixthSense_1
//
//  Created by PadilKeren on 07/11/24.
//

import SwiftUI

struct ProfileCardView: View {
    @State private var isSheetPresented = false
    
    enum variantType {
        case catalogPage
        case cartPage
    }
    
    var VariantType: variantType
    
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
                            Text("Nikol")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundStyle(.labelPrimary)
                            HStack {
                                Image(systemName: "location.fill")
                                    .font(.system(size: 13))
                                    .foregroundStyle(.labelSecondary)
                                    .padding(.trailing, -5)
                                Text("1 km")
                                    .font(.footnote)
                                    .fontWeight(.regular)
                                    .foregroundStyle(.labelSecondary)
                            }
                        }
                        Spacer()
                        
                        switch VariantType {
                        case .catalogPage:
                            Text("Rp0 - Rp50k") // range harga
                                .font(.subheadline)
                                .foregroundStyle(.labelSecondary)
                            
                        case .cartPage:
                            Button {
                                // masuk ke keranjang
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
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(0...5, id: \.self) { _ in
                                Button {
                                    isSheetPresented = true
                                } label: {
                                    AllCardView(variantType: .catalogMiniPage)
                                        .padding(.horizontal, 2)
                                }
                            }
                            .sheet(isPresented: $isSheetPresented) {
                                DetailCardView(variantType: .edit, descType: .descON)
                                    .presentationDetents([.fraction(0.8), .large])
                            }
                        }
                        .frame(height: 233)
                        .padding(.leading, 16)
                    }
                    .scrollIndicators(.hidden)
                }
            )
            .clipShape(RoundedRectangle(cornerRadius: 6))
            .shadow(color: Color.black.opacity(0.04), radius: 4, x: 0, y: 0)
            .shadow(color: Color.black.opacity(0.06), radius: 8, x: 4, y: 2)
    }
}

#Preview {
    ProfileCardView(VariantType: .catalogPage)
}

//finished
