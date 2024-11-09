//
//  EditItemView.swift
//  ProfileBajuSixthSense_1
//
//  Created by PadilKeren on 09/11/24.
//

import SwiftUI

struct EditItemView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Edit Pakaian")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundStyle(.labelPrimary)
            
            Text("Ada yang kurang? Update lagi pakaianmu!")
                .font(.body)
                .fontWeight(.regular)
                .foregroundStyle(.labelSecondary)
                .padding(.bottom, 16)
            
            EditCardView()
            
            Spacer()
            
            Button {
                // save button
            } label: {
                Rectangle()
                    .frame(width: 361, height: 50)
                    .foregroundColor(.systemPurple)
                    .cornerRadius(6)
                    .overlay(
                        Text("Simpan")
                            .font(.body)
                            .fontWeight(.regular)
                            .foregroundStyle(.systemPureWhite)
                    )
            }
        }
        .navigationTitle("Profile")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    // action hapus
                } label: {
                    Text("Hapus")
                }
            }
        }
    }
}

#Preview {
    EditItemView()
}
