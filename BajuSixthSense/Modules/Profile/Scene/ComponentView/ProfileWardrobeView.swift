//
//  ProfileWardrobeView.swift
//  ProfileBajuSixthSense_1
//
//  Created by PadilKeren on 07/11/24.
//

import SwiftUI

struct ProfileWardrobeView: View {
    var columnLayout: [GridItem] = Array(repeating: GridItem(.fixed(0), spacing: 188, alignment: .center), count: 2)
    @State private var isSheetPresented = false
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columnLayout, spacing: 16) {
                ForEach(0...5, id: \.self) { _ in
                    Button {
                        isSheetPresented = true
                    } label: {
                        AllCardView(variantType: .wardrobePage)
                    }
                    .padding(.horizontal, 2)
                }
                .sheet(isPresented: $isSheetPresented) {
                    DetailCardView(variantType: .edit, descType: .descON)
                        .presentationDetents([.fraction(0.8), .large])
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    ProfileWardrobeView()
}
