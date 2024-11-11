//
//  ProfileWardrobeView.swift
//  ProfileBajuSixthSense_1
//
//  Created by PadilKeren on 07/11/24.
//

import SwiftUI

struct ProfileWardrobeView: View {
    var columnLayout: [GridItem] = Array(repeating: GridItem(.fixed(0), spacing: 188, alignment: .center), count: 2)
    var clothes: [ClothEntity]
    @State private var isSheetPresented = false
    @State private var selectedCloth: ClothEntity
    
    @Binding var showSelection: Bool
    
    enum variantType {
        case penerima
        case pemberi
    }
    
    var VariantType: variantType
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columnLayout, spacing: 16) {
                ForEach(clothes, id: \.self) { cloth in
                    Button {
                        selectedCloth = cloth
                        isSheetPresented = true
                    } label: {
                        
                        switch VariantType {
                            
                        case .penerima:
                            AllCardView(variantType: .cartPage)
                            
                        case .pemberi:
                            if (showSelection) {
                                AllCardView(variantType: .editPage)
                            } else {
                                AllCardView(variantType: .wardrobePage)
                            }
                        }
                    }
                    .padding(.horizontal, 2)
                }
                .sheet(isPresented: $isSheetPresented) {
                    DetailCardView(cloth: selectedCloth, variantType: .edit, descType: .descON)
                        .presentationDetents([.fraction(0.8), .large])
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}

//#Preview {
//    ProfileWardrobeView(showSelection: $showSelection, VariantType: .penerima)
//}
