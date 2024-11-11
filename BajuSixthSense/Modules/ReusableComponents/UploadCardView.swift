//
//  EditCardView.swift
//  ProfileBajuSixthSense_1
//
//  Created by PadilKeren on 07/11/24.
//

import SwiftUI

struct UploadCardView: View {
    let typeOfClothes = ["", "Kaos", "Kemeja", "Jaket", "Hoodie", "Rok", "Celana Panjang", "Celana Pendek"]
    let colorOfClothes = ["", "Hitam", "Putih", "Abu-Abu", "Merah", "Coklat", "Kuning", "Hijau", "Biru", "Ungu", "Pink"]
    let defectofClothes = ["", "Noda", "Lubang", "Pudar", "Kancing Hilang"]
    
    @State private var typeSelectedOptionIndex = 0
    @State private var colorSelectedOptionIndex = 0
    @State private var showTypeDropdown = false
    @State private var showColorDropdown = false
    @State private var showDefectDropdown = false
    @State private var selectedDefects = [0]
    @State private var pasangHarga = false
    
    @Binding var typeText: String
    @Binding var colorText: String
    @Binding var defectText: [String]
    @Binding var descriptionText: String
    @Binding var clothPrice: Int
    
    var image: UIImage
    var isUploadCardView: Bool
    
    var body: some View {
        ZStack {
            if isUploadCardView {
                Rectangle()
                    .frame(width: 361, height: 306)
                    .foregroundStyle(.systemPureWhite)
                    .cornerRadius(6)
                    .shadow(color: Color.black.opacity(0.04), radius: 4, x: 0, y: 0)
                    .shadow(color: Color.black.opacity(0.06), radius: 8, x: 4, y: 2)
            }
            
            VStack(alignment: .leading) {
                HStack {
                    Image(uiImage: image)
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
                        }
                        .padding(.bottom, -4)
                        
                        ZStack {
                            DropDownMenu(
                                options: typeOfClothes,
                                selectedOptionIndex: $typeSelectedOptionIndex,
                                showDropdown: $showTypeDropdown,
                                selectedDefects: $selectedDefects,
                                typeText: $typeText,
                                colorText: $colorText,
                                selectedDefectTexts: $defectText,
                                dropdownType: "Type"
                            )
                        }
                        .zIndex(showTypeDropdown ? 4 : 1)
                        .padding(.bottom, 6)
                        
                        Text("Warna")
                            .font(.footnote)
                            .fontWeight(.regular)
                            .padding(.bottom, -4)
                        
                        ZStack {
                            DropDownMenu(
                                options: colorOfClothes,
                                menuWidth: 203,
                                selectedOptionIndex: $colorSelectedOptionIndex,
                                showDropdown: $showColorDropdown,
                                selectedDefects: $selectedDefects,
                                typeText: $typeText,
                                colorText: $colorText,
                                selectedDefectTexts: $defectText,
                                dropdownType: "Color"
                            )
                            .zIndex(showColorDropdown ? 3 : 1)
                        }
                    }
                    .foregroundStyle(.labelPrimary)
                }
                .zIndex(2)
                
                Text("Kerusakan")
                    .font(.footnote)
                    .fontWeight(.regular)
                    .padding(.bottom, -4)
                    .padding(.top, 4)
                
                ZStack {
                    DropDownMenu(
                        options: defectofClothes,
                        menuWidth: 329,
                        selectedOptionIndex: $colorSelectedOptionIndex,
                        showDropdown: $showDefectDropdown,
                        selectedDefects: $selectedDefects,
                        typeText: $typeText,
                        colorText: $colorText,
                        selectedDefectTexts: $defectText,
                        dropdownType: "Defects"
                    )
                }
                .zIndex(showDefectDropdown ? 3 : 1)
                
                Text("Deskripsi")
                    .font(.footnote)
                    .fontWeight(.regular)
                    .padding(.bottom, -4)
                    .padding(.top, 4)
                
                TextField("Ada sedikit noda", text: $descriptionText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .overlay {
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(.black, lineWidth: 1)
                    }
                    .font(.subheadline)
                
                HStack {
                    Toggle("", isOn: $pasangHarga)
                        .toggleStyle(CustomToggleStyle())
                        .labelsHidden()
                    
                    Text("Pasang Harga (Rp)")
                        .font(.footnote)
                        .fontWeight(.regular)
                        .padding(.leading, -24)
                    
                    Spacer()
                    
                    TextField("Cloth Price", value: $clothPrice, format: .number)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .overlay {
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(pasangHarga ? .black : .labelBlack400, lineWidth: 1)
                        }
                        .font(.subheadline)
                        .foregroundStyle(pasangHarga ? .systemBlack : .labelBlack400)
                        .disabled(!pasangHarga)
                }
                .padding(.top, 4)
            }
            .zIndex(1)
            .padding(16)
        }
    }
}

//#Preview {
//    UploadCardView()
//}
