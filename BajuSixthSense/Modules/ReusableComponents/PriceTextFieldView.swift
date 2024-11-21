//
//  PriceTextFieldView.swift
//  BajuSixthSense
//
//  Created by Jovanna Melissa on 20/11/24.
//

import SwiftUI

struct PriceTextFieldView: View {
    @Binding var price: Int
    @Binding var pasangHarga: Bool
    
    var body: some View {
        TextField("Harga baju", value: $price,
            format: .number)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .overlay {
                RoundedRectangle(cornerRadius: 6)
                    .stroke(pasangHarga ? .black : .labelBlack400, lineWidth: 1)
            }
            .font(.subheadline)
            .foregroundStyle(pasangHarga ? .systemBlack : .labelBlack400)
            .disabled(!pasangHarga)
    }
}
