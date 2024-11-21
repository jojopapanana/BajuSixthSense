//
//  LongCardView.swift
//  ProfileBajuSixthSense_1
//
//  Created by PadilKeren on 07/11/24.
//

import SwiftUI

struct LongCardView: View {
    var cloth: ClothEntity
    let onDelete: () -> Void
    
    var body: some View {
        Rectangle()
            .frame(width: 345, height: 114)
            .foregroundStyle(.systemPureWhite)
            .cornerRadius(6)
            .overlay(
                HStack {
                    Image(uiImage: cloth.photo ?? UIImage(systemName: "exclamationmark.triangle.fill")!)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 114, height: 114)
                    
                    VStack(alignment: .leading) {
                        Text("\(cloth.generateClothName())")
                            .font(.footnote)
                            .fontWeight(.semibold)
                        
                        Text(cloth.generateDefectsString())
                            .font(.caption)
                            .fontWeight(.regular)
                            .foregroundStyle(.labelSecondary)
                        
                        Spacer()
                        
                        Text("Rp \(cloth.price)")
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
                            Image(systemName: "plus")
                                .font(.system(size: 13))
                                .foregroundStyle(.labelPrimary)
                                .rotationEffect(Angle(degrees: 45))
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
