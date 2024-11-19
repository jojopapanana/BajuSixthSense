//
//  EditItemView.swift
//  ProfileBajuSixthSense_1
//
//  Created by PadilKeren on 09/11/24.
//

import SwiftUI

struct EditItemView: View {
    @State private var isButtonDisabled = false
    var index: Int
    @ObservedObject var wardrobeVM: WardrobeViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Edit Pakaian")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundStyle(.labelPrimary)
                .padding(.horizontal)
            
            Text("Ada yang kurang? Update lagi pakaianmu!")
                .font(.body)
                .fontWeight(.regular)
                .foregroundStyle(.labelSecondary2)
                .padding(.bottom, 16)
                .padding(.horizontal)
            
            UploadCardView(
                index: index,
                isUploadCardView: false
            )
            
            Spacer()
            
            Button {
                do {
                    try wardrobeVM.updateWardrobe(cloth: wardrobeVM.fetchWardrobeItems()[index])
                } catch {
                    print("Failed saving changes")
                }
            } label: {
                CustomButtonView(buttonType: .primary, buttonWidth: 361, buttonLabel: "Simpan", isButtonDisabled: $isButtonDisabled)
            }
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    do {
                        try wardrobeVM.removeWardrobe(id: wardrobeVM.fetchWardrobeItems()[index].id)
                    } catch {
                        print("Failed removing wardrobe")
                    }
                } label: {
                    Text("Hapus")
                }
            }
        }
    }
}

//#Preview {
//    EditItemView()
//}
