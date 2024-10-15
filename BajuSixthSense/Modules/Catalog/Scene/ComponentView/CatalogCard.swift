//
//  CatalogCard.swift
//  BajuSixthSense
//
//  Created by PadilKeren on 10/10/24.
//

//import SwiftUI

//struct CatalogCard: View {
//    @State private var isBookmarked: Bool = false
//    var distance: String = "1"
//    var numberOfClothes: Int = 0
//    let tags = ["shirt", "T-Shirt"]
//    
//    var body: some View {
//        VStack {
//            ZStack {
//                // carousel gambar
//                ScrollView(.horizontal, showsIndicators: false) {
//                    HStack {
//                        // gak tau kenapa kalo gambarnya di swipe kagak center dan lama2 makin gak center
//                        ForEach(CatalogCardModels) { card in
//                            Image(card.image)
//                                .resizable()
//                                .background(Color.systemWhite)
//                                .aspectRatio(contentMode: .fill)
//                                .frame(width: 161, height: 188)
//                                .clipShape(RoundedRectangle(cornerRadius: 3.49))
//                                .clipped()
//                                .overlay(
//                                    RoundedRectangle(cornerRadius: 3.49)
//                                        .stroke(Color.systemBlack, lineWidth: 0.33)
//                                )
//                        }
//                    }
//                }
//                .frame(width: 161)
//                .scrollTargetBehavior(.paging)
//                
//                // lokasi
//                VStack(alignment: .trailing) {
//                    HStack {
//                        ZStack {
//                            UnevenRoundedRectangle(bottomTrailingRadius: 3.46)
//                                .foregroundStyle(Color.systemWhite)
//                                .frame(height: 20)
//                                .overlay(
//                                    UnevenRoundedRectangle(topLeadingRadius: 3.46, bottomTrailingRadius: 3.46)
//                                        .stroke(Color.systemBlack, lineWidth: 0.33)
//                                )
//                            HStack(spacing: 4) {
//                                Image(systemName: "location.circle")
//                                    .resizable()
//                                    .frame(width: 12, height: 12)
//                                    .padding(.leading, 8)
//                                
//                                Text("1 km away")
//                                    .font(.system(size: 12))
//                                    .tracking(-0.23)
//                                    .lineLimit(1)
//                                Spacer()
//                            }
//                        }
//                        .frame(width: 92) // ngakalin width biar gak titik2
//                        Spacer()
//                    }
//                    Spacer()
//                }
//                .clipShape(
//                    RoundedRectangle(cornerRadius: 3.46)
//                )
//                
//                //bookmark
//                VStack {
//                    HStack {
//                        Spacer()
//                        ZStack {
//                            Circle()
//                                .frame(width: 30, height: 30)
//                                .foregroundStyle(Color.white)
//                                .overlay(
//                                    RoundedRectangle(cornerRadius: 40)
//                                        .stroke(Color.systemBlack, lineWidth: 1)
//                                )
//                            Button(action: {
//                                // action bookmark disini
//                                isBookmarked.toggle()
//                                print("Bookmark button tapped")
//                            }) {
//                                Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
//                                    .foregroundStyle(Color.black)
//                                    .contentShape(Circle())
//                            }
//                        }
//                        .padding(5)
//                    }
//                    Spacer()
//                }
//                
//            }
//            
//            .frame(width: 161, height:  188)
//            
//            // indicator
//            Circle()
//                .frame(width: 4, height: 4)
//            
//            // numberOfClothes
//            HStack {
//                Image(systemName: "tray.full")
//                    .padding(.leading, 5)
//                Text("10 Clothes") // ngakalin data numberOfClothes
//                    .font(.system(size: 14, weight: .semibold))
//                    .tracking(-0.23)
//                    .lineLimit(1)
//                Spacer()
//            }
//            .frame(width: 161)
//            
//            // tags
//            HStack {
//                // masih ngakalin data tags
//                Text("Shirt")
//                    .font(.system(size: 13))
//                    .tracking(-0.4)
//                    .padding(.horizontal, 5)
//                    .padding(.vertical, 3)
//                    .frame(height: 24)
//                    .background(Color.systemWhite)
//                    .foregroundColor(Color.systemBlack)
//                    .cornerRadius(40)
//                    .shadow(radius: 0.62)
//                Text("T-Shirt")
//                    .font(.system(size: 13))
//                    .tracking(-0.4)
//                    .padding(.horizontal, 5)
//                    .padding(.vertical, 3)
//                    .frame(height: 24)
//                    .background(Color.systemWhite)
//                    .foregroundColor(Color.systemBlack)
//                    .cornerRadius(40)
//                    .shadow(radius: 0.62)
//                Text("More")
//                    .font(.system(size: 13))
//                    .tracking(-0.4)
//                Spacer()
//                
//            }
//            .frame(width: 161)
//        }
//    }
//}
//
//#Preview {
//    CatalogCard()
//}
