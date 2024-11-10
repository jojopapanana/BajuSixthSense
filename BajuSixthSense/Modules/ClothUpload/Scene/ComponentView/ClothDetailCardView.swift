//
//  ClothDetailCardView.swift
//  BajuSixthSense
//
//  Created by Jovanna Melissa on 09/11/24.
//

import SwiftUI

struct ClothDetailCardView: View {
    @State private var isPriceChecked = false
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 6)
                .foregroundStyle(.white)
                .shadow(radius: 4)
            
            VStack{
                HStack{
                    ZStack{
                        RoundedRectangle(cornerRadius: 6)
                            .foregroundStyle(.backgroundBlack100)
                        
                        Image("BusinessHappyHandsUp")
                            .resizable()
                    }
                    .frame(width: 114, height: 114)
                    
                    VStack{
                        HStack{
                            Text("Jenis Pakaian")
                                .font(.footnote)
                            
                            Spacer()
                            Image(systemName: "plus")
                                .rotationEffect(.degrees(45))
                                .font(.footnote)
                        }
                        
                        //Dropdown
                        
                        Text("Warna")
                            .font(.footnote)
                        
                        //Dropdown
                    }
                }
                
                Text("Kerusakan")
                    .font(.footnote)
                
                //Dropdown
                
                Text("Deskripsi")
                    .font(.footnote)
                
                //Textfield
                
                HStack{
                    Toggle(isOn: $isPriceChecked) {
                        Text("Pasang harga (Rp)")
                    }
                    .toggleStyle(SwitchToggleStyle(tint: .systemBlack))
                    
                    //textfield
                }
            }
        }
        .frame(width: 361, height: 306)
    }
}

#Preview {
    ClothDetailCardView()
}
