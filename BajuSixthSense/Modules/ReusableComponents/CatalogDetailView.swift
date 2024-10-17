//
//  ProductDetailReceiverView.swift
//  BajuSixthSense
//
//  Created by PadilKeren on 12/10/24.
//

import SwiftUI

struct CatalogDetailView: View {
    var distance = 1.4
    var bulk: CatalogItemEntity
    
    @State private var currentPage = 0
    @State private var bookmarkClicked = false
    @State var isOwner: Bool
    @State var isButtonDisabled: Bool = false
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                Color.systemBGBase
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack {
//                        ProductDetailImage(numberofClothes: 5)
                        
                        // number of clothes + Distance
                        HStack {
                            Image(systemName: "tray.full")
                                .frame(width: 20, height: 20)
                                .foregroundStyle(.labelSecondary)
                                .padding(.trailing, 6)
                            
                            VStack(alignment: .leading) {
                                Text("Total Clothes")
                                    .font(.subheadline)
                                    .foregroundStyle(Color.labelSecondary)
                                
                                // numberOfClothes
                                Text("10 Clothes")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(Color.labelPrimary)
                            }
                            
                            Spacer()
                            
                            if !isOwner{
                                Divider()
                                    .frame(width: 0.33, height: 55)
                                
                                Image(systemName: "location.circle")
                                    .frame(width: 20, height: 20)
                                    .foregroundStyle(.labelSecondary)
                                    .padding(.trailing, 6)
                                    .padding(.leading, 16)
                                
                                VStack(alignment: .leading) {
                                    Text("Distance")
                                        .font(.subheadline)
                                        .foregroundStyle(.labelSecondary)
                                    
                                    // distance
                                    Text("\(String(format: "%.0f", round(distance))) km away")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(Color.labelPrimary)
                                }
                                
                                Spacer()
                            }
                        }
                        .padding(.top, 30)
                        
                        // Clothes Type
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Clothes Type")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(Color.labelPrimary)
                                    .padding(.bottom, 2)
                                
                                Text("Type of clothes included in the clothes bulk")
                                    .font(.footnote)
                                    .foregroundStyle(Color.labelSecondary)
                                
                                Divider()
                                    .frame(width: 350, height: 0.33)
                                    .padding(.bottom, 10)
                                
                                //change to bulk's tags
                                HStack{
                                    ForEach(bulk.category, id:\.self){category in
                                        LabelView(labelText: category.rawValue, fontType: .subheadline, horizontalPadding: 14, verticalPadding: 7)
                                    }
                                }
                            }
                            Spacer()
                        }
                        .padding(.top, 24)
                        
                        // Additional information
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Additional Information")
                                    .font(.headline)
                                    .foregroundStyle(Color.labelPrimary)
                                    .padding(.bottom, 2)
                                
                                Text("Additional detail description about clothes bulk")
                                    .font(.footnote)
                                    .foregroundStyle(Color.labelSecondary)
                                
                                Divider()
                                    .frame(width: 350, height: 0.33)
                                    .padding(.bottom, 10)
                                
                                // change to additional information
                                Text(bulk.additionalNotes)
                                    .font(.footnote)
                                    .foregroundStyle(Color.labelSecondary)
                            }
                            
                            Spacer()
                        }
                        .padding(.top, 24)
                        
                        if !isOwner{
                            // About Giver
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("About Giver")
                                        .font(.headline)
                                        .foregroundStyle(Color.labelPrimary)
                                        .padding(.bottom, 2)
                                    
                                    Text("Giver information")
                                        .font(.footnote)
                                        .foregroundStyle(Color.labelSecondary)
                                    
                                    Divider()
                                        .frame(width: 350, height: 0.33)
                                        .padding(.bottom, 10)
                                    
                                    HStack {
                                        // navigation link harusnya ke profile
                                        NavigationLink{
                                            ProfileView()
                                        } label: {
                                            Image(systemName: "person.fill")
                                                .resizable()
                                                .frame(width: 13, height: 13)
                                                .foregroundStyle(Color.labelPrimary)
                                            
                                            // nama akun
                                            Text("Jessica")
                                                .font(.footnote)
                                                .foregroundStyle(Color.labelPrimary)
                                                .underline()
                                                .padding(.leading, 6)
                                        }
                                    }
                                }
                                Spacer()
                            }
                            .padding(.top, 24)
                        }
                        
                        Button {
//                            if let url = URL(string: "https://wa.me/6285781665957") {
//                                UIApplication.shared.open(url)
//                            }
                        } label: {
                            CustomButtonView(buttonType: .primary, buttonWidth: 360, buttonLabel: isOwner ? "Edit" : "Chat on Whatsapp", isButtonDisabled: $isButtonDisabled)
                        }
                        .padding(.top, 40)
                    }
                }
                .padding(.horizontal)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    HStack {
                        if !isOwner{
                            Button {
                                // bookmark functionality
                                bookmarkClicked.toggle()
                            } label: {
                                if !bookmarkClicked{
                                    Image(systemName: "bookmark")
                                        .font(.system(size: 16))
                                } else {
                                    Image(systemName: "bookmark.fill")
                                        .font(.system(size: 16))
                                }
                            }
                        }
                        
                        ShareLink(
                            "",
                            item: Image("DefaultHappyHandsUp"), // image yg dishare
                            message: Text(
                                "Hello, is it me your looking for~~~\n\(URL(string: "www.google.com")!)"
                            ), // copywriting yg dishare
                            preview: SharePreview(
                                "10 Clothes", // title preview
                                icon: Image("DefaultHappyHandsUp") // image utama preview
                            )
                        )
                    }
                }
            }
        }
    }
}

//#Preview {
//    CatalogDetailView(isOwner: true)
//}
