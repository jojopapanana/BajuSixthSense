////
////  ProductDetailGiverView.swift
////  BajuSixthSense
////
////  Created by PadilKeren on 12/10/24.
////
//
//import SwiftUI
//
//struct ProductDetailGiverView: View {
//    var numberofClothes:Int
//    @State private var currentPage = 0
//    @State private var bookmarkClicked = false
//    
//    var body: some View {
//        NavigationStack {
//            ZStack {
//                Color("systemWhite")
//                    .ignoresSafeArea()
//                
//                ScrollView(.vertical) {
//                    VStack {
//                        ProductDetailImage(numberofClothes: 5)
//                        
//                        // number of clothes + Distance
//                        HStack {
//                            Image(systemName: "tray.full")
//                                .frame(width: 20, height: 20)
//                                .foregroundStyle(Color.systemGrey1)
//                                .padding(.trailing, 6)
//                                .padding(.leading, 16)
//                            
//                            VStack(alignment: .leading) {
//                                Text("Total Clothes")
//                                    .font(.system(size: 15))
//                                    .tracking(-0.4)
//                                    .foregroundStyle(Color.systemGrey1)
//                                
//                                // numberOfClothes
//                                Text("10 Clothes")
//                                    .font(.system(size: 20, weight: .semibold))
//                                    .tracking(-0.4)
//                                    .foregroundStyle(Color.systemBlack)
//                            }
//                            Spacer()
//                        }
//                        .padding(.top, 30)
//                        
//                        // Clothes Type
//                        HStack {
//                            VStack(alignment: .leading) {
//                                Text("Clothes Type")
//                                    .font(.system(size: 17, weight: .semibold))
//                                    .tracking(-0.4)
//                                    .foregroundStyle(Color.systemBlack)
//                                    .padding(.bottom, 2)
//                                
//                                Text("Type of clothes are included in clothes bulk")
//                                    .font(.system(size: 13))
//                                    .tracking(-0.4)
//                                    .foregroundStyle(Color.systemGrey1)
//                                
//                                Divider()
//                                    .frame(width: 350, height: 0.33)
//                                    .padding(.bottom, 10)
//                                
//                                
//                                // harusnya wrappedHStack, tags
//                                HStack {
//                                    Text("Shirt")
//                                        .font(.system(size: 15))
//                                        .tracking(-0.4)
//                                        .padding(.horizontal, 14)
//                                        .padding(.vertical, 7)
//                                        .frame(height: 34)
//                                        .background(Color.systemGrey2)
//                                        .foregroundColor(Color.systemBlack)
//                                        .cornerRadius(16)
//                                }
//                            }
//                            Spacer()
//                        }
//                        .padding(.leading, 16)
//                        .padding(.top, 24)
//                        
//                        // Additional information
//                        HStack {
//                            VStack(alignment: .leading) {
//                                Text("Additional Information")
//                                    .font(.system(size: 17, weight: .semibold))
//                                    .tracking(-0.4)
//                                    .foregroundStyle(Color.systemBlack)
//                                    .padding(.bottom, 2)
//                                
//                                Text("Additional detail description about clothes bulk")
//                                    .font(.system(size: 13))
//                                    .tracking(-0.4)
//                                    .foregroundStyle(Color.systemGrey1)
//                                
//                                Divider()
//                                    .frame(width: 350, height: 0.33)
//                                    .padding(.bottom, 10)
//                                
//                                // additional information
//                                Text("Consist of 10 clothes with stain on shirt, open seams on some t-shirt, but overall all in good condition, contact me to get more details")
//                                    .font(.system(size: 13))
//                                    .tracking(-0.4)
//                                    .foregroundStyle(Color.systemGrey1)
//                            }
//                            Spacer()
//                        }
//                        .padding(.leading, 16)
//                        .padding(.top, 24)
//                        
//                        // About Giver
//                        HStack {
//                            VStack(alignment: .leading) {
//                                Text("About Giver")
//                                    .font(.system(size: 17, weight: .semibold))
//                                    .tracking(-0.4)
//                                    .foregroundStyle(Color.systemBlack)
//                                    .padding(.bottom, 2)
//                                
//                                Text("Giver information")
//                                    .font(.system(size: 13))
//                                    .tracking(-0.4)
//                                    .foregroundStyle(Color.systemGrey1)
//                                
//                                Divider()
//                                    .frame(width: 350, height: 0.33)
//                                    .padding(.bottom, 10)
//                                
//                                HStack {
//                                    // navigation link harusnya ke profile
//                                    NavigationLink(destination: ProductDetailReceiverView(numberofClothes: 2)) {
//                                        // foto profil
//                                        Image(systemName: "person.fill")
//                                            .resizable()
//                                            .frame(width: 13, height: 13)
//                                            .foregroundStyle(Color.systemBlack)
//                                        
//                                        // nama akun
//                                        Text("Jessica")
//                                            .font(.system(size: 13))
//                                            .foregroundStyle(Color.systemBlack)
//                                            .underline()
//                                            .padding(.leading, 6)
//                                    }
//                                }
//                            }
//                            Spacer()
//                        }
//                        .padding(.leading, 16)
//                        .padding(.top, 24)
//                        
//                        Button {
//                            // action edit
//                        } label: {
//                            Rectangle()
//                                .frame(width: 360, height: 50)
//                                .foregroundStyle(Color.systemPrimary)
//                                .cornerRadius(12)
//                                .padding(.top, 23)
//                                .overlay(
//                                    Text("Edit")
//                                        .font(.system(size: 17))
//                                        .foregroundStyle(Color.systemWhite)
//                                        .padding(.top, 20)
//                                )
//                        }
//                    }
//                }
//            }
//            .navigationBarTitleDisplayMode(.inline)
//            .toolbar {
//                ToolbarItem(placement: .topBarTrailing) {
//                    HStack {
//                        Button {
//                            bookmarkClicked.toggle()
//                        } label: {
//                            if !bookmarkClicked{
//                                Image(systemName: "bookmark")
//                                    .font(.system(size: 16))
//                            } else {
//                                Image(systemName: "bookmark.fill")
//                                    .font(.system(size: 16))
//                            }
//                        }
//
//                        //Use the template
////                        ShareLink(
////                            item: "Copywriting sharelink gaessss www.youtube.com", // copywriting pas sharenya
////                            preview: SharePreview("10 Clothes\nuweeee", image: Image(systemName: "square.and.arrow.up"))
////                            // cari tahu cara kasih subtitle yg bener
////                            // Image() ngikutin preview gambar utama
////                        ) {
////                            Image(systemName: "square.and.arrow.up")
////                                .foregroundStyle(Color.systemPrimary)
////                        }
//                    }
//                }
//            }
//        }
//    }
//}
//
//#Preview {
//    ProductDetailGiverView(numberofClothes: 5)
//}
