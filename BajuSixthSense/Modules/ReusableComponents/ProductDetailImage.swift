//
//  ProductDetailReceiverImage.swift
//  BajuSixthSense
//
//  Created by PadilKeren on 12/10/24.
//

import SwiftUI

struct ProductDetailImage: View {
//    var numberofClothes: Int
    var clothes: [UIImage?]
    @State private var currentPage = 0
    
    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                ForEach(clothes, id: \.self) { cloth in
                    PhotoFrame(
                        width: 289,
                        height: 331,
                        cornerRadius: 12,
                        image: cloth
                    )
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: 331)
            .padding(.bottom, 12)
            
            HStack(spacing: 8) {
                ForEach(0..<clothes.count, id: \.self) { index in
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
    ProductDetailImage(clothes: [nil, nil, nil])
}
