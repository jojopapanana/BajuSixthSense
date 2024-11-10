//
//  EditCardView.swift
//  ProfileBajuSixthSense_1
//
//  Created by PadilKeren on 07/11/24.
//

import SwiftUI

struct UploadCardView: View {
    let typeOfClothes = ["Kaos", "Kemeja", "Jaket", "Hoodie", "Rok", "Celana Panjang", "Celana Pendek"]
    let colorOfClothes = ["Hitam", "Putih", "Abu-Abu", "Merah", "Coklat", "Kuning", "Hijau", "Biru", "Ungu", "Pink"]
    let defectofClothes = ["Noda", "Lubang", "Pudar", "Kancing Hilang"]
    
    @State private var selectedOptionIndex = 0
    @State private var showDropdown =  false
    @State private var pasangHarga = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 361, height: 306)
                .foregroundStyle(.systemPureWhite)
                .cornerRadius(6)
                .overlay(
                    VStack(alignment: .leading) {
                        HStack {
                            Image("Image")
                                .resizable()
                                .frame(width: 114, height: 114)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(.systemBlack, lineWidth: 2)
                                )
                                .cornerRadius(6)
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("Jenis Pakaian")
                                        .font(.footnote)
                                        .fontWeight(.regular)
                                    Spacer()
                                    Button {
                                        // action buat apus harusnya
                                    } label: {
                                        Image(systemName: "xmark")
                                            .font(.system(size: 13))
                                            .foregroundStyle(.labelPrimary)
                                    }
                                }
                                .padding(.bottom, -4)
                                
                                DropDownMenu(options: typeOfClothes, selectedOptionIndex: $selectedOptionIndex, showDropdown: $showDropdown)
                                    .zIndex(2)
                                    .padding(.bottom, 6)
                                
                                Text("Warna")
                                    .font(.footnote)
                                    .fontWeight(.regular)
                                    .padding(.bottom, -4)
                                
                                // Warna width: 203, height: 32
                                Rectangle()
                                    .frame(width: 203, height: 32)
                                    .foregroundStyle(.clear)
                                    .cornerRadius(6)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 6)
                                            .stroke(.systemBlack, lineWidth: 1)
                                    )
                            }
                            .foregroundStyle(.labelPrimary)
                        }
                        .zIndex(1)
                        
                        Text("Kerusakan")
                            .font(.footnote)
                            .fontWeight(.regular)
                            .padding(.bottom, -4)
                            .padding(.top, 4)
                        
                        // Defect width: 203, height: 32
                        Rectangle()
                            .frame(width: 329, height: 32)
                            .foregroundStyle(.clear)
                            .cornerRadius(6)
                            .overlay(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(.systemBlack, lineWidth: 1)
                            )
                        
                        Text("Detail")
                            .font(.footnote)
                            .fontWeight(.regular)
                            .padding(.bottom, -4)
                            .padding(.top, 4)
                        
                        // nih harusnya textfield
                        Rectangle()
                            .frame(width: 329, height: 32)
                            .foregroundStyle(.clear)
                            .cornerRadius(6)
                            .overlay(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(.systemBlack, lineWidth: 1)
                            )
                        
                        HStack {
                            Toggle("", isOn: $pasangHarga)
                                .toggleStyle(CustomToggleStyle())
                                .labelsHidden()
                            
                            Text("Pasang Harga (Rp)")
                                .font(.footnote)
                                .fontWeight(.regular)
                                .padding(.leading, -24)
                            
                            Spacer()
                            
                            Rectangle()
                                .frame(width: 146, height: 32)
                                .foregroundStyle(.clear)
                                .cornerRadius(6)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(.systemBlack, lineWidth: 1)
                                )
                        }
                        .padding(.top, 4)
                    }
                    .padding(16)
                )
                .shadow(color: Color.black.opacity(0.04), radius: 4, x: 0, y: 0)
                .shadow(color: Color.black.opacity(0.06), radius: 8, x: 4, y: 2)
        }
    }
}

#Preview {
    UploadCardView()
}
