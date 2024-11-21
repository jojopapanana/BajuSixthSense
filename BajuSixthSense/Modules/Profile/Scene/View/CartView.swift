//
//  CartView.swift
//  BajuSixthSense
//
//  Created by PadilKeren on 10/11/24.
//

import SwiftUI

struct CartView: View {
    @ObservedObject var cartVM = ClothCartViewModel.shared
    
    var body: some View {
        ZStack {
            Color.systemBackground
            ScrollView {
                VStack {
                    HStack {
                        Text(cartVM.getFirstCharacter())
                            .font(.title)
                            .foregroundStyle(.white)
                            .padding(18)
                            .background(
                                Circle()
                                    .foregroundStyle(.systemBlack)
                            )
                        
                        VStack(alignment: .leading) {
                            Text(cartVM.getUsername())
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundStyle(.labelPrimary)
                            
                            Text(cartVM.getDistance())
                                .font(.footnote)
                                .fontWeight(.regular)
                                .foregroundStyle(.labelSecondary)
                        }
                        
                        Spacer()
                    }
                }
                .padding(.horizontal)
                
                VStack(spacing: 16) {
                    ForEach(cartVM.clothEntities.value ?? [ClothEntity]()) { cloth in
                        LongCardView(
                            cloth: cloth,
                            onDelete: {
                                if cartVM.catalogCart.clothItems.count == 1{
                                    do{
                                        try cartVM.emptyCurrCart()
                                    } catch {
                                        print("Error in emptying cart")
                                    }
                                } else {
                                    cartVM.removeCartItem(cloth: cloth)
                                    cartVM.removeFromCartCatalog(id: cloth.id ?? "")
                                }
                            }
                        )
                    }
                }
            }
        }
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "basket.fill")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundStyle(.labelPrimary)
                
                Text("\(cartVM.catalogCart.clothItems.count) item")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundStyle(.labelPrimary)
                    .padding(.leading, -4)
            }
            
            Text("Pilih lebih banyak yuk, biar penampilan lebih beragam!")
                .font(.footnote)
                .fontWeight(.regular)
                .foregroundStyle(.labelSecondary)
            
            Button {
                CatalogViewModel().chatGiver(
                    phoneNumber: cartVM.getContactInfo(),
                    message: """
                        Halo, saya ingin beli barang ini:\n\(cartVM.clothEntities.value?.map { $0.generateClothName() }.joined(separator: "\n") ?? "Tidak ada barang")
                    """
                )
            } label: {
                Rectangle()
                    .frame(width: 361, height: 50)
                    .foregroundStyle(.systemPurple)
                    .cornerRadius(6)
                    .overlay(
                        Text("Chat Via WhatsApp")
                            .font(.body)
                            .fontWeight(.regular)
                            .foregroundStyle(.systemPureWhite)
                    )
            }
        }
    }
}

#Preview {
    CartView()
}
