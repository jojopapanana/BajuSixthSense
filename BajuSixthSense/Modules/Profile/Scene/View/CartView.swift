//
//  CartView.swift
//  BajuSixthSense
//
//  Created by PadilKeren on 10/11/24.
//

import SwiftUI

struct CartView: View {
    var body: some View {
        ZStack {
            Color.systemBackground
            ScrollView {
                VStack {
                    HStack {
                        Text("P")
                            .font(.title)
                            .foregroundStyle(.white)
                            .padding(18)
                            .background(
                                Circle()
                                    .foregroundStyle(.systemBlack)
                            )
                        
                        VStack(alignment: .leading) {
                            Text("Username")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundStyle(.labelPrimary)
                            
                            Text("1 km") // distance
                                .font(.footnote)
                                .fontWeight(.regular)
                                .foregroundStyle(.labelSecondary)
                        }
                        
                        Spacer()
                        
                    }
                }
                .padding(.horizontal)
                
                VStack(spacing: 16) {
                    ForEach(0...5, id: \.self) { _ in
                        LongCardView()
                    }
                }
            }
        }
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "basket.fill")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundStyle(.labelPrimary)
                Text("3 Item")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundStyle(.labelPrimary)
                    .padding(.leading, -4)
            }
            Text("Pilih lebih banyak yuk, biar penampilan lebih beragam!")
                .font(.footnote)
                .fontWeight(.regular)
                .foregroundStyle(.labelSecondary)
            Button {
                // chat whatsapp
            } label: {
                Rectangle()
                    .frame(width: 361, height: 50)
                    .foregroundStyle(.systemPurple)
                    .cornerRadius(6)
                    .overlay(
                        Text("Chat WhatsApp")
                            .font(.body)
                            .fontWeight(.regular)
                            .foregroundStyle(.systemPureWhite)
                    )
            }
        }
    }
}

#Preview {
    CartView()
}
