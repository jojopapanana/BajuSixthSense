//
//  WardrobeClothesView.swift
//  BajuSixthSense
//
//  Created by Jovanna Melissa on 10/10/24.
//

import SwiftUI

struct ClothesCardView: View {
    @State private var currentPage = 0
    @State var bookmarkClicked: Bool
    var bulk: CatalogItemEntity
    
    @ObservedObject var catalogVM: CatalogViewModel
    
    var body: some View {
        VStack(alignment: .leading){
            VStack{
                ZStack{
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
                    
                    VStack{
                        HStack{
                            HStack(spacing: 0){
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
                            .padding(.vertical, 2.5)
                            .overlay(
                                RoundedCorner(radius: 3.49, corners: [.topLeft, .bottomRight])
                                    .stroke(.black, lineWidth: 0.33)
                            )
                            Spacer()
                        }
                        
                        HStack{
                            Spacer()
                            
                            Button{
                                if bookmarkClicked {
                                    catalogVM.bookmarkItem(clothID: bulk.id)
                                } else {
                                    catalogVM.unBookmarkItem(clothID: bulk.id)
                                }
                                bookmarkClicked.toggle()
                            } label: {
                                ZStack{
                                    Circle()
                                        .fill(Color.white)
                                        .frame(width: 30, height: 30)
                                    Image(systemName: "circle")
                                        .font(.system(size: 30))
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
                    ForEach(0..<5) { index in
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
            .frame(width: 161)
            
            HStack{
                if let firstTag = bulk.category.first?.rawValue {
                    LabelView(labelText: firstTag, fontType: .footnote, horizontalPadding: 5, verticalPadding: 3)
                }
                
                if bulk.category[1].rawValue.isEmpty == false {
                    LabelView(labelText: bulk.category[1].rawValue, fontType: .footnote, horizontalPadding: 5, verticalPadding: 3)
                }
                
                Text("More")
                    .font(.footnote)
            }
            .foregroundStyle(Color.labelPrimary)
        }
        .frame(width: 165)
    }
}

//#Preview {
//    ClothesCardView(numberofClothes: 5, bookmarkClicked: false)
//}
