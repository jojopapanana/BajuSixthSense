//
//  PriceFilterSheetView.swift
//  BajuSixthSense
//
//  Created by Jovanna Melissa on 11/11/24.
//

import SwiftUI

struct PriceFilterSheetView: View {
    @Binding var isSheetShowing: Bool
    
    @State private var minimumPrice = 0.0
    @State private var maximumPrice = 500000.0
    @Binding var currentMinPrice: Double
    @Binding var currentMaxPrice: Double
    
    @ObservedObject var viewModel: CatalogViewModel
    
    var body: some View {
        VStack{
            VStack(alignment: .leading){
                HStack{
                    Text("Range Harga")
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Button{
                        isSheetShowing = false
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(.systemBlack)
                    }
                }
                
                Text("Geser slider untuk menemukan pilihan yang lebih sesuai.")
                    .font(.footnote)
                    .foregroundStyle(.labelSecondary)
            }
            .padding(.top, -20)
            
            HStack{
                Text("Rp\(Int(currentMinPrice)) - Rp\(Int(currentMaxPrice))")
                if(currentMaxPrice == 500000){
                    Text("+")
                        .padding(0)
                }
            }
            .padding([.top, .bottom], 15)
            
            GeometryReader { geometry in
                let width = geometry.size.width - 20
                let thumbSize: CGFloat = 20
                let sliderRange = width - thumbSize
                
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color.gray.opacity(0.4))
                        .frame(height: 4)
                        .padding(.horizontal, thumbSize / 2)
                    
                    Rectangle()
                        .fill(Color.systemPurple)
                        .frame(width: CGFloat((currentMaxPrice - currentMinPrice) / (maximumPrice - minimumPrice)) * sliderRange, height: 4)
                        .offset(x: CGFloat((currentMinPrice - minimumPrice) / (maximumPrice - minimumPrice)) * sliderRange + thumbSize / 2)
                    
                    Circle()
                        .frame(width: thumbSize, height: thumbSize)
                        .foregroundColor(.systemPurple)
                        .offset(x: CGFloat((currentMinPrice - minimumPrice) / (maximumPrice - minimumPrice)) * sliderRange)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    let location = value.location.x - thumbSize / 2
                                    let percentage = max(0, min(1, location / sliderRange))
                                    let rawValue = minimumPrice + percentage * (maximumPrice - minimumPrice)
                                    
                                    let roundedValue = round(rawValue / 10000) * 10000
                                    
                                    currentMinPrice = min(currentMaxPrice, roundedValue)
                                }
                        )
                    
                    Circle()
                        .frame(width: thumbSize, height: thumbSize)
                        .foregroundColor(.systemPurple)
                        .offset(x: CGFloat((currentMaxPrice - minimumPrice) / (maximumPrice - minimumPrice)) * sliderRange)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    let location = value.location.x - thumbSize / 2
                                    let percentage = max(0, min(1, location / sliderRange))
                                    let rawValue = minimumPrice + percentage * (maximumPrice - minimumPrice)
                                    
                                    let roundedValue = round(rawValue / 10000) * 10000
                                    
                                    currentMaxPrice = min(maximumPrice, max(minimumPrice, roundedValue))
                                }
                        )
                }
                .padding(.horizontal, thumbSize / 2)
            }
            .frame(height: 40)
            
            Button{
                viewModel.filterCatalogItems(minPrice: currentMinPrice, maxPrice: currentMaxPrice)
                isSheetShowing = false
            } label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 6)
                        .fill(.systemBlack)
                    
                    Text("Terapkan")
                        .foregroundStyle(.systemPureWhite)
                }
                .frame(width: 361, height: 50)
            }
        }
        .padding()
    }
}

//#Preview {
//    PriceFilterSheetView()
//}
