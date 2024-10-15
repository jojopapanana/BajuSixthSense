//
//  ProductDetailReceiverImage.swift
//  BajuSixthSense
//
//  Created by PadilKeren on 12/10/24.
//

import SwiftUI

struct ProductDetailImage: View {
    var numberofClothes:Int
    @State private var currentPage = 0
    
    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                ForEach(0..<numberofClothes, id: \.self) { index in
                    Image("bajusample")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 289, height: 331)
                        .overlay(RoundedRectangle(cornerRadius: 12)
                            .stroke(.black, lineWidth: 1)
                            .foregroundStyle(.clear))
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: 331)
            .padding(.bottom, 12)
            
            HStack(spacing: 8) {
                ForEach(0..<5) { index in
                    Circle()
                        .frame(width: 8, height: 8)
                        .foregroundColor(index == self.currentPage ? .black : .gray)
                        .onTapGesture(perform: { self.currentPage = index })
                }
            }
        }
    }
}

#Preview {
    ProductDetailImage(numberofClothes: 10)
}
