//
//  UploadNumberOfClothesView.swift
//  MacroChallenge
//
//  Created by PadilKeren on 04/10/24.
//

import SwiftUI

struct UploadNumberOfClothesView: View {
    var formatter: NumberFormatter = NumberFormatter()

    @State var qty: Int?
    @ObservedObject var uploadVM: UploadClothViewModel
    
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
                .foregroundStyle(Color.labelPrimary)
                .padding(.horizontal)
            
            Divider()
                .frame(width: 350)
                .foregroundStyle(Color.labelPrimary)
                .padding(.horizontal)
                .padding(.bottom, 13)
            
            HStack {
                TextField(
                    "0",
                    value: $qty,
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
                        .foregroundStyle(Color.systemPureWhite)
                        .onTapGesture {
                            let count = qty ?? 0
                            if count > 0 {
                                qty = count - 1
                            }
                        }
                    
                    Divider()
                        .frame(width: 1, height: 18)
                        .foregroundStyle(Color.labelPrimary)
                    
                    Image(systemName: "plus")
                        .frame(width: 47, height: 32)
                        .contentShape(RoundedRectangle(cornerRadius: 10))
                        .foregroundStyle(Color.systemPureWhite)
                        .onTapGesture {
                            let count = qty ?? 0
                            if count == 0 {
                                qty = 1
                            } else {
                                qty = count + 1
                            }
                        }
                }
                .frame(width: 94, height: 32)
                .background(Color.systemBlack)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .padding(.horizontal)
            .onChange(of: qty) { oldValue, newValue in
                uploadVM.defaultCloth.quantity = qty
                uploadVM.checkFields()
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            self.hideKeyboard()
        }
        .onAppear {
            initializeFormatter(formatter: formatter)
            if uploadVM.defaultCloth.quantity != nil  {
                qty = uploadVM.defaultCloth.quantity
            }
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
