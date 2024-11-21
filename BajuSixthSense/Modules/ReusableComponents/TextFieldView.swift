//
//  TextFieldView.swift
//  BajuSixthSense
//
//  Created by Jovanna Melissa on 20/11/24.
//

import SwiftUI

struct TextFieldView: View {
    @Binding var text: String
    
    var body: some View {
        TextField("Ada sedikit noda", text: $text)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .overlay {
                RoundedRectangle(cornerRadius: 6)
                    .stroke(.black, lineWidth: 1)
            }
            .font(.subheadline)
    }
}
