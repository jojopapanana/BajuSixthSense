//
//  NewUserCartSheetView.swift
//  BajuSixthSense
//
//  Created by Jovanna Melissa on 21/11/24.
//

import SwiftUI

struct NewUserCartSheetView: View {
    @Binding var isPresented: Bool
    
    @ObservedObject var cartVM = ClothCartViewModel.shared
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 6)
                .fill(.systemBackground)
            
            VStack{
                Image("changecartillus")
                    .resizable()
                    .frame(width: 340, height: 180)
                
                Text("Jadi mau ganti katalog yang lain, nih?")
                    .foregroundStyle(.systemBlack)
                    .fontWeight(.semibold)
                    .padding(.top, 12)
                
                Text("Boleh, aja. Tapi, pakaian di keranjang yang sudah kamu pilih dari katalog lain, akan kami hapus ya.")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .padding(.top, 12)
                    .foregroundStyle(.labelBlack400)
                
                HStack{
                    Button {
                        isPresented = false
                    } label: {
                        Rectangle()
                            .frame(width: 162, height: 50)
                            .foregroundStyle(.systemPureWhite)
                            .cornerRadius(6)
                            .overlay(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(style: StrokeStyle(lineWidth: 1))
                                    .foregroundStyle(.systemBlack)
                            )
                            .overlay(
                                Text("Kembali")
                                    .foregroundStyle(.systemBlack)
                            )
                    }
                    
                    Button {
                        do {
                            try cartVM.emptyCurrCart()
                        } catch {
                            print("Error trying to empty the cart and inserting over")
                        }
                        isPresented = false
                    } label: {
                        Rectangle()
                            .frame(width: 162, height: 50)
                            .foregroundStyle(.systemBlack)
                            .cornerRadius(6)
                            .overlay(
                                Text("Kosongkan")
                                    .foregroundStyle(.systemPureWhite)
                            )
                    }
                }
            }
        }
        .frame(height: 347)
    }
}

//#Preview {
//    NewUserCartSheetView()
//}
