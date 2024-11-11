//
//  EditCardView.swift
//  BajuSixthSense
//
//  Created by PadilKeren on 10/11/24.
//

import SwiftUI

struct EditCardView: View {
    let typeOfClothes = ["Kaos", "Kemeja", "Jaket", "Hoodie", "Rok", "Celana Panjang", "Celana Pendek"]
    let colorOfClothes = ["Hitam", "Putih", "Abu-Abu", "Merah", "Coklat", "Kuning", "Hijau", "Biru", "Ungu", "Pink"]
    let defectofClothes = ["Noda", "Lubang", "Pudar", "Kancing Hilang"]
    
    @State private var selectedOptionIndex = 0
    @State private var showDropdown =  false
    @State private var pasangHarga = false
    @State private var selectedDefects = [0]
    
    @Binding var typeText: String
    @Binding var colorText: String
    @Binding var defectText: [String]
    @Binding var descriptionText: String
    @Binding var clothPrice: Int
    
    var body: some View {
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
                    Text("Jenis Pakaian")
                        .font(.footnote)
                        .fontWeight(.regular)
                    
                    // bikin dropdown lagi buat edit (pake enum aja kali yak)
                    DropDownMenu(options: typeOfClothes, selectedOptionIndex: $selectedOptionIndex, showDropdown: $showDropdown, selectedDefects: $selectedDefects, typeText: $typeText, colorText: $colorText, selectedDefectTexts: $defectText, dropdownType: "Type")
                        .zIndex(2)
                        .padding(.bottom, 6)
                    
                    Text("Warna")
                        .font(.footnote)
                        .fontWeight(.regular)
                        .padding(.bottom, -4)
                    
                    // Warna width: 235, height: 32
                    Rectangle()
                        .frame(width: 235, height: 32)
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
            
            // Defect width: 361, height: 32
            Rectangle()
                .frame(width: 361, height: 32)
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
                .frame(width: 361, height: 32)
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
                
                // harusnya textfield harga (width: 178, height: 32)
                Rectangle()
                    .frame(width: 178, height: 32)
                    .foregroundStyle(.clear)
                    .cornerRadius(6)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(.systemBlack, lineWidth: 1)
                    )
                    .padding(.leading, 4)
            }
            .padding(.top, 4)
        }
        .padding(16)
        
    }
}

//#Preview {
//    EditCardView()
//}
