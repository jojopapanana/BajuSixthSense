//
//  UploadNumberOfClothesView.swift
//  MacroChallenge
//
//  Created by PadilKeren on 04/10/24.
//

import SwiftUI

struct UploadNumberOfClothesView: View {
    @ObservedObject var uploadVM: UploadClothViewModel
    var formatter: NumberFormatter = NumberFormatter()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Number of Clothes")
                .font(.system(size: 17, weight: .semibold))
                .tracking(-0.4)
                .foregroundStyle(Color.systemBlack)
                .padding(.horizontal)
            
            Text("Enter the total numbers of clothes in your bulk")
                .font(.system(size: 13))
                .tracking(-0.4)
                .foregroundStyle(Color.systemGrey1)
                .padding(.horizontal)
            
            Divider()
                .frame(width: 350)
                .foregroundStyle(Color.systemGrey1)
                .padding(.horizontal)
                .padding(.bottom, 13)
            
            HStack {
                TextField(
                    "0",
                    value: $uploadVM.defaultCloth.quantity,
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
                        .foregroundStyle(Color.systemWhite)
                        .onTapGesture {
                            uploadVM.decrementQty()
                        }
                    
                    Divider()
                        .frame(width: 1, height: 18)
                        .foregroundStyle(Color.systemGrey1)
                    
                    Image(systemName: "plus")
                        .frame(width: 47, height: 32)
                        .contentShape(RoundedRectangle(cornerRadius: 10))
                        .foregroundStyle(Color.systemWhite)
                        .onTapGesture {
                            uploadVM.incrementQty()
                        }
                }
                .frame(width: 94, height: 32)
                .background(Color.systemBlack)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .padding(.horizontal)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            self.hideKeyboard()
        }
        .onAppear {
            initializeFormatter(formatter: formatter)
        }
    }
}

extension UploadNumberOfClothesView {
    func initializeFormatter(formatter: NumberFormatter){
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        formatter.maximumFractionDigits = 0
    }
}

//#Preview {
//    UploadNumberOfClothesView()
//}
