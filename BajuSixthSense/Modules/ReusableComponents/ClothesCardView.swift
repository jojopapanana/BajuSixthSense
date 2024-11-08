//
//  WardrobeClothesView.swift
//  BajuSixthSense
//
//  Created by Jovanna Melissa on 10/10/24.
//

import SwiftUI

struct ClothesCardView: View {
    @State private var currentPage = 0
    @State var bookmarkClicked: Bool = false
    var bulk: CatalogItemEntity
    
    @ObservedObject var catalogVM = CatalogViewModel.shared
    @ObservedObject var bookmarkVM: BookmarkViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack {
                ZStack {
                    TabView(selection: $currentPage){
                        ForEach(bulk.photos, id: \.self){ image in
                            PhotoFrame(
                                width: 161,
                                height: 188,
                                cornerRadius: 3.5,
                                image: image)
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    
                    VStack {
                        HStack {
                            HStack(spacing: 0) {
                                Image(systemName: "location.circle")
                                    .fontWeight(.light)
                                    .font(.system(size: 11))
                                    .foregroundStyle(Color.systemBlack)
                                Text(
                                    "\(String(format: "%.0f", round(bulk.distance ?? 0))) km away"
                                )
                                    .font(.system(size: 11))
                                    .foregroundStyle(Color.systemBlack)
                            }
                            .padding(.horizontal, 4)
                            .padding(.vertical, 2)
                            .background {
                                Color.systemPureWhite
                                .clipShape(RoundedCorner(radius: 3.49, corners: [.topLeft, .bottomRight]))
                            }
                            .overlay(
                                RoundedCorner(radius: 3.49, corners: [.topLeft, .bottomRight])
                                    .stroke(.black, lineWidth: 0.33)
                            )
                            
                            Spacer()
                        }
                        .offset(x: 0.5, y: 1)
                        
                        HStack{
                            Spacer()
                            
                            Button{
                                if BookmarkViewModel.checkIsBookmark(catalogItem: bulk) {
                                    do {
                                        try bookmarkVM.removeBookmark(id: bulk.id)
                                    } catch {
                                        print("Error removing bookmark: \(error.localizedDescription)")
                                    }
                                    bookmarkClicked = false
                                } else {
                                    catalogVM.bookmarkItem(clothID: bulk.id)
                                    bookmarkClicked = true
                                }
                            } label: {
                                ZStack{
                                    Circle()
                                        .fill(Color.white)
                                        .frame(width: 30, height: 30)
                                    Image(systemName: "circle")
                                        .font(.system(size: 32))
                                        .fontWeight(.ultraLight)
                                    
                                    if !bookmarkClicked{
                                        Image(systemName: "bookmark")
                                            .font(.system(size: 16))
                                    } else {
                                        Image(systemName: "bookmark.fill")
                                            .font(.system(size: 16))
                                    }
                                    
                                }
                                .foregroundStyle(Color.systemBlack)
                            }
                            .padding(.trailing, 3)
                            .padding(.top, -23)
                        }
                        Spacer()
                    }
                }
                .frame(height: 190)
                
                HStack(spacing: 4) {
                    ForEach(0..<bulk.photos.count, id: \.self) { index in
                        Circle()
                            .frame(width: 4, height: 4)
                            .foregroundColor(index == self.currentPage ? .black : .gray)
                            .onTapGesture(perform: { self.currentPage = index })
                    }
                }
                .padding(.bottom, 4)
            }
            
            HStack {
                Image(systemName: "tray.full")
                    .font(.system(size: 14, weight: .light))
                    .foregroundStyle(Color.systemBlack)
                    .padding(.leading, 5)
                Text("\(bulk.quantity) Clothes")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(Color.systemBlack)
                    .tracking(-0.23)
                    .lineLimit(1)
                Spacer()
            }
            
            HStack(spacing: 5) {
                LabelView(
                    labelText: bulk.category[0].rawValue,
                    fontType: .footnote,
                    horizontalPadding: 5,
                    verticalPadding: 3
                )
                
                if bulk.category.count > 1 {
                    LabelView(
                        labelText: bulk.category[1].rawValue,
                        fontType: .footnote,
                        horizontalPadding: 5,
                        verticalPadding: 3
                    )
                }
                
                Text("More")
                    .font(.footnote)
            }
            .foregroundStyle(Color.labelPrimary)
        }
        .frame(width: 161)
        .onAppear {
            bookmarkClicked = BookmarkViewModel.checkIsBookmark(catalogItem: bulk)
        }
    }
}

//#Preview {
//    ClothesCardView(numberofClothes: 5, bookmarkClicked: false)
//}
