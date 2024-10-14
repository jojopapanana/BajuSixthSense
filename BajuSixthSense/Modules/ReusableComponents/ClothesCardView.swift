//
//  WardrobeClothesView.swift
//  BajuSixthSense
//
//  Created by Jovanna Melissa on 10/10/24.
//

import SwiftUI

struct ClothesCardView: View {
    var numberofClothes:Int
    @State private var currentPage = 0
    @State var bookmarkClicked:Bool
    
    var body: some View {
        VStack(alignment: .leading){
            VStack{
                ZStack{
                    TabView(selection: $currentPage){
                        ForEach(0..<numberofClothes){index in
                            Image("bajusample")
                                .resizable()
                                .overlay(RoundedRectangle(cornerRadius: 3.49)
                                    .stroke(.black, lineWidth: 0.33)
                                    .foregroundStyle(.clear))
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    
                    
                    VStack{
                        HStack{
                            HStack(spacing: 0){
                                Image(systemName: "location.circle")
                                    .fontWeight(.light)
                                    .font(.system(size: 11))
                                Text("1 km away")
                                    .font(.system(size: 11))
                            }
                            .padding(.horizontal, 4)
                            .padding(.vertical, 2.5)
                            .background(
                                RoundedCorner(radius: 3.49, corners: [.topLeft, .bottomRight])
                                    .fill(.clear)
                            )
                            .overlay(
                                RoundedCorner(radius: 3.49, corners: [.topLeft, .bottomRight])
                                    .stroke(.black, lineWidth: 0.33)
                            )
                            Spacer()
                        }
                        
                        HStack{
                            Spacer()
                            
                            Button{
                                #warning("TO-DO: add bookmark functionality")
                                bookmarkClicked.toggle()
                            } label: {
                                ZStack{
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
                                .foregroundStyle(.black)
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
            }
            
            
            HStack{
                Image(systemName: "tray")
                Text("10 clothes")
                    .fontWeight(.semibold)
            }
            .padding(.bottom, 3)
            
            HStack{
                LabelView(labelText: "Shirt", horizontalPadding: 5, verticalPadding: 3)
                LabelView(labelText: "T-Shirt", horizontalPadding: 5, verticalPadding: 3)
                Text("More")
            }
        }
        .frame(width: 165)
    }
}

//#Preview {
//    ClothesCardView(numberofClothes: 5)
//}
