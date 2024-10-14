//
//  LabelView.swift
//  BajuSixthSense
//
//  Created by Jovanna Melissa on 10/10/24.
//

import SwiftUI

struct LabelView: View {
    var labelText:String
    var horizontalPadding:CGFloat
    var verticalPadding:CGFloat
    
    var body: some View {
        Text(labelText)
            .padding(.horizontal, horizontalPadding)
            .padding(.vertical, verticalPadding)
            .background(
                RoundedRectangle(cornerRadius: 40) .fill(.systemWhite.shadow(.drop(color: .black, radius: 0)))
            )
            
    }
}

#Preview {
    LabelView(labelText: "Shirt", horizontalPadding: 5, verticalPadding: 3)
}