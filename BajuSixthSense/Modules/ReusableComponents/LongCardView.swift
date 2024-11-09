//
//  LongCardView.swift
//  ProfileBajuSixthSense_1
//
//  Created by PadilKeren on 07/11/24.
//

import SwiftUI

struct LongCardView: View {
    var body: some View {
        Rectangle()
            .frame(width: 345, height: 114)
            .foregroundStyle(.systemPureWhite)
            .cornerRadius(6)
            .overlay(
                HStack {
                    Image("Image")
                        .resizable()
                        .frame(width: 114, height: 114)
                    VStack(alignment: .leading) {
                        Text("Kemeja")
                            .font(.footnote)
                            .fontWeight(.semibold)
                        Text("Lubang • Noda • +2")
                            .font(.caption)
                            .fontWeight(.regular)
                            .foregroundStyle(.labelSecondary)
                        Spacer()
                        Text("Rp 8.000")
                            .font(.footnote)
                            .fontWeight(.semibold)
                    }
                    .foregroundStyle(.systemBlack)
                    .padding(.vertical, 12)
                    Spacer()
                    VStack {
                        Button {
                            // action buat apus harusnya
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

#Preview {
    LongCardView()
}

//finished
