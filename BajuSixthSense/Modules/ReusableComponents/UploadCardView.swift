//
//  EditCardView.swift
//  ProfileBajuSixthSense_1
//
//  Created by PadilKeren on 07/11/24.
//

import SwiftUI

struct UploadCardView: View {
    @State private var pasangHarga = false
    var index: Int
    var cloth: ClothEntity
    @ObservedObject var uploadVM = UploadClothViewModel.shared
    @ObservedObject var wardrobeVM = WardrobeViewModel.shared
    
    var isUploadCardView: Bool
    
    var body: some View {
        ZStack {
//            if isIndexValid{
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
                        Image(
                            uiImage: cloth.photo ?? UIImage(systemName: "exclamationmark.triangle.fill")!
                        )
                            .resizable()
                            .scaledToFit()
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
                                    options: DropDownType.Category.getOptions,
                                    index: index,
                                    dropdownType: .Category,
                                    isUpload: isUploadCardView
                                )
                            }
                            .zIndex(4)
                            .padding(.bottom, 6)
                            
                            Text("Warna")
                                .font(.footnote)
                                .fontWeight(.regular)
                                .padding(.bottom, -4)
                            
                            ZStack {
                                DropDownMenu(
                                    options: DropDownType.Color.getOptions,
                                    index: index,
                                    dropdownType: .Color,
                                    isUpload: isUploadCardView
                                )
                            }
                            .zIndex(3)
                        }
                        .foregroundStyle(.labelPrimary)
                    }
                    .zIndex(2)
                    
                    Text("Kerusakan")
                        .font(.footnote)
                        .fontWeight(.regular)
                        .padding(.bottom, -4)
                        .padding(.top, 2)
                    
                    ZStack {
                        DropDownMenu(
                            menuWidth: isUploadCardView ? 329 : 361,
                            options: DropDownType.Defects.getOptions,
                            index: index,
                            dropdownType: .Defects,
                            isUpload: isUploadCardView
                        )
                    }
                    .zIndex(1)
                    
                    Text("Deskripsi")
                        .font(.footnote)
                        .fontWeight(.regular)
                        .padding(.bottom, -4)
                        .padding(.top, 4)
                    
                    if (isUploadCardView && index < uploadVM.clothesUpload.count) || (!isUploadCardView && index < wardrobeVM.wardrobeItems.count){
                        TextField("Ada sedikit noda", text: isUploadCardView ? $uploadVM.clothesUpload[index].description : $wardrobeVM.wardrobeItems[index].description)
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
                            
                            TextField("Cloth Price", value: isUploadCardView ? $uploadVM.clothesUpload[index].price : $wardrobeVM.wardrobeItems[index].price, format: .number)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .overlay {
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(pasangHarga ? .black : .labelBlack400, lineWidth: 1)
                                }
                                .font(.subheadline)
                                .foregroundStyle(pasangHarga ? .systemBlack : .labelBlack400)
                                .disabled(!pasangHarga)
                        }
                        .onAppear(perform: {
                            if !isUploadCardView && wardrobeVM.wardrobeItems[index].price != 0{
                                pasangHarga = true
                            }
                        })
                        .padding(.top, 4)
                    }
                    
                }
                .padding(16)
                .background(Color.clear)
//            }
        }
    }
}

//#Preview {
//    UploadCardView()
//}
