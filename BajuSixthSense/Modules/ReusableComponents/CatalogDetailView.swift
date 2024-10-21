//
//  ProductDetailReceiverView.swift
//  BajuSixthSense
//
//  Created by PadilKeren on 12/10/24.
//

import SwiftUI

struct CatalogDetailView: View {
    var bulk: CatalogItemEntity
    var isOwner: Bool
    
    @State private var currentPage = 0
    @State private var bookmarkClicked = false
    @State var isButtonDisabled: Bool = false
    
    @EnvironmentObject var navigationRouter: NavigationRouter
    @ObservedObject var catalogVM = CatalogViewModel.shared
    
    var body: some View {
        ZStack {
            Color.systemBGBase
                .ignoresSafeArea()
            
            ScrollView {
                VStack {
                    ProductDetailImage(clothes: bulk.photos)
                    
                    HStack {
                        Image(systemName: "tray.full")
                            .frame(width: 20, height: 20)
                            .foregroundStyle(.labelSecondary)
                            .padding(.trailing, 6)
                        
                        VStack(alignment: .leading) {
                            Text("Total Clothes")
                                .font(.subheadline)
                                .foregroundStyle(Color.labelSecondary)
                            
                            Text("\(bulk.quantity) Clothes")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundStyle(Color.labelPrimary)
                        }
                        
                        Spacer()
                        
                        if !isOwner {
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
                                
                                Text("\(String(format: "%.0f", round(bulk.distance ?? 0))) km away")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(Color.labelPrimary)
                            }
                            
                            Spacer()
                        }
                    }
                    .padding(.top, 30)
                    
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
                            
                            HStack{
                                ForEach(bulk.category, id:\.self) { category in
                                    LabelView(labelText: category.rawValue, fontType: .subheadline, horizontalPadding: 14, verticalPadding: 7)
                                }
                            }
                        }
                        Spacer()
                    }
                    .padding(.top, 24)
                    
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
                            
                            Text(bulk.additionalNotes)
                                .font(.footnote)
                                .foregroundStyle(Color.labelSecondary)
                        }
                        
                        Spacer()
                    }
                    .padding(.top, 24)
                    
                    if !isOwner {
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
                                    Button {
                                        navigationRouter.push(to: .Profile(
                                            items: catalogVM.filterItemByOwner(
                                                ownerID: bulk.owner.id
                                            )
                                        ))
                                    } label: {
                                        Image(systemName: "person.fill")
                                            .resizable()
                                            .frame(width: 13, height: 13)
                                            .foregroundStyle(Color.labelPrimary)
                                        
                                        Text(bulk.owner.username)
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
                        if isOwner {
                            navigationRouter.goBack()
                            navigationRouter.push(to: .Upload(state: .Edit, cloth: bulk.mapEntity()))
                        } else {
                            catalogVM.chatGiver(
                                phoneNumber: bulk.owner.contactInfo,
                                message: "Hello there!, I would like to inquire about your catalog"
                            )
                        }
                    } label: {
                        CustomButtonView(
                            buttonType: .primary,
                            buttonWidth: 360,
                            buttonLabel: isOwner ? "Edit" : "Chat on Whatsapp",
                            isButtonDisabled: $isButtonDisabled
                        )
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
                    if !isOwner {
                        Button {
                            if BookmarkViewModel.checkIsBookmark(catalogItem: bulk) {
                                catalogVM.unBookmarkItem(clothID: bulk.id)
                                bookmarkClicked = false
                            } else {
                                catalogVM.bookmarkItem(clothID: bulk.id)
                                bookmarkClicked = true
                            }
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
                        item: Image(
                            uiImage: bulk.photos[0] ?? UIImage(
                                systemName: "exclamationmark.triangle.fill"
                            )!
                        ),
                        message: Text(
                            "Check out this catalog!\n\n\(catalogVM.getShareLink(clothId: bulk.id))"
                        ),
                        preview: SharePreview(
                            "\(bulk.quantity)",
                            icon: Image(
                                uiImage: bulk.photos[0] ?? UIImage(
                                    systemName: "exclamationmark.triangle.fill"
                                )!
                            )
                        )
                    )
                }
            }
        }
        .onAppear {
            bookmarkClicked = BookmarkViewModel.checkIsBookmark(catalogItem: bulk)
        }
    }
}

//#Preview {
//    CatalogDetailView(isOwner: true)
//}
