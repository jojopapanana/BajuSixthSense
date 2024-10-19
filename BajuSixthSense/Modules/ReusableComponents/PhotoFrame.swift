//
//  PhotoFrame.swift
//  BajuSixthSense
//
//  Created by Stevans Calvin Candra on 16/10/24.
//

import SwiftUI

struct PhotoFrame: View {
    var width: CGFloat
    var height: CGFloat
    var cornerRadius: CGFloat
    var image: UIImage?
    
    var body: some View {
        VStack {
            if image != nil {
                Image(uiImage: image!)
                    .resizable()
                    .scaledToFill()
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            } else {
                Image(systemName: "exclamationmark.triangle.fill")
            }
        }
        .frame(width: width, height: height)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(Color.systemBlack, lineWidth: 0.33)
        )
    }
}

#Preview {
    //    PhotoFrame()
}
