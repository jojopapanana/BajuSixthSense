//
//  UploadNumberOfClothesView.swift
//  MacroChallenge
//
//  Created by PadilKeren on 04/10/24.
//

import SwiftUI

struct UploadNumberOfClothesView: View {
    @State private var numberOfClothes: Int?
    private let formatter: NumberFormatter
    
    init() {
            formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.groupingSeparator = "." // Use "," if you want a comma as the grouping separator
        formatter.maximumFractionDigits = 0 // Ensure no decimal places
        }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Number of Clothes")
                .font(.custom("Montserrat-SemiBold", size: 17))
                .padding(.horizontal)
            
            Text("Enter the total numbers of clothes in your bulk")
                .padding(.horizontal)
                .font(.system(size: 13))
                .tracking(-0.4)
                .foregroundStyle(Color.gray)
            
            Rectangle()
                .frame(width: 350, height: 0.3)
                .foregroundStyle(Color.gray)
                .padding(.horizontal)
                .padding(.bottom, 15)
            
            HStack {
//                TextField("0", text: Binding(
//                    get: {
//                        String(numberOfClothes)
//                    },
//                    set: { newValue in
//                        if let value = Int(newValue) {
//                            numberOfClothes = value
//                        }
//                    }
//                ))
//                .frame(width: 70, height: 32)
//                .keyboardType(.numberPad)
//                .overlay(
//                    RoundedRectangle(cornerRadius: 10)
//                        .stroke(lineWidth: 1)
//                )
//                .multilineTextAlignment(.center)
//                .padding(.trailing, 5)
                
                TextField(
                    numberOfClothes == nil ? "0" : String(numberOfClothes!),
                    value: $numberOfClothes,
                    formatter: formatter
                )
                .frame(width: 70, height: 32)
                .keyboardType(.numberPad)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 1)
                )
                .multilineTextAlignment(.center)
                .padding(.trailing, 5)
                
                HStack(spacing: 0) {
                    Image(systemName: "minus")
                        .frame(width: 47, height: 32)
                        .contentShape(RoundedRectangle(cornerRadius: 10))
                        .foregroundStyle(Color.white)
                        .onTapGesture {
                            if numberOfClothes ?? 0 > 0 {
                                numberOfClothes! -= 1
                            }
                        }
                    
                    Rectangle()
                        .frame(width: 1, height: 18)
                        .foregroundStyle(Color.gray)
                    
                    Image(systemName: "plus")
                        .frame(width: 47, height: 32)
                        .contentShape(RoundedRectangle(cornerRadius: 10))
                        .foregroundStyle(Color.white)
                        .onTapGesture {
                            if numberOfClothes == nil {
                                numberOfClothes = 1
                            } else {
                                numberOfClothes! += 1
                            }
                        }
                    
                }
                .frame(width: 94, height: 32)
                .background(Color.black)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .padding(.horizontal)
        }
        .contentShape(Rectangle()) // Makes the whole view tappable.
                .onTapGesture {
                    self.hideKeyboard()
                }
    }
}

#Preview {
    UploadNumberOfClothesView()
}
