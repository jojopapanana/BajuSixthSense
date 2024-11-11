//
//  LongCardView.swift
//  ProfileBajuSixthSense_1
//
//  Created by PadilKeren on 07/11/24.
//

import SwiftUI

struct LongCardView: View {
    var image: UIImage
    var type: String
    var color: String
    var defects: [String]
    var price: Int
    
    let onDelete: () -> Void
    
    var body: some View {
        Rectangle()
            .frame(width: 345, height: 114)
            .foregroundStyle(.systemPureWhite)
            .cornerRadius(6)
            .overlay(
                HStack {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 114, height: 114)
                    
                    VStack(alignment: .leading) {
                        Text("\(type) \(color)")
                            .font(.footnote)
                            .fontWeight(.semibold)
                        
                        if(defects.count == 2){
                            Text(defects[1])
                                .font(.caption)
                                .fontWeight(.regular)
                                .foregroundStyle(.labelSecondary)
                        } else if (defects.count == 3) {
                            Text("\(defects[1]) · \(defects[2])")
                                .font(.caption)
                                .fontWeight(.regular)
                                .foregroundStyle(.labelSecondary)
                        } else if (defects.count >= 4){
                            Text("\(defects[1]) · \(defects[2]) · +\(defects.count - 3)")
                                .font(.caption)
                                .fontWeight(.regular)
                                .foregroundStyle(.labelSecondary)
                        }
                        
                        Spacer()
                        
                        Text("Rp \(price)")
                            .font(.footnote)
                            .fontWeight(.semibold)
                    }
                    .foregroundStyle(.systemBlack)
                    .padding(.vertical, 12)
                    
                    Spacer()
                    
                    VStack {
                        Button {
                            onDelete()
                        } label: {
                            Image(systemName: "xmark")
                                .font(.system(size: 13))
                                .foregroundStyle(.labelPrimary)
                        }
                        Spacer()
                    }
                    .padding(12)
                }
            )
            .clipShape(RoundedRectangle(cornerRadius: 6))
            .shadow(color: Color.black.opacity(0.04), radius: 4, x: 0, y: 0)
            .shadow(color: Color.black.opacity(0.06), radius: 8, x: 4, y: 2)
    }
}

//#Preview {
//    LongCardView()
//}
//
////finished
