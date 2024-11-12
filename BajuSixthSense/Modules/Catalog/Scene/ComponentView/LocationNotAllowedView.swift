//
//  LocationNotAllowedView.swift
//  BajuSixthSense
//
//  Created by Jovanna Melissa on 15/10/24.
//

import SwiftUI

struct LocationNotAllowedView: View {
    @Binding var isButtonDisabled: Bool
    
    var body: some View {
        VStack {
            Text("Oops! Gak bisa cari kelomang di dekatmu nih")
                .font(.title2)
                .fontWeight(.semibold)
                .tracking(-0.4)
                .lineSpacing(2.8)
                .foregroundStyle(Color.systemBlack)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .padding(.bottom, 11)
            
            Text("Bantu kami tampilkan katalog terbaik di dekatmu. Izinkan akses lokasi, supaya bisa lihat pilihan terdekat yang mungkin pas untuk kamu!")
                .font(.subheadline)
                .tracking(-0.4)
                .lineSpacing(2.0)
                .foregroundStyle(Color.labelSecondary2)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .padding(.bottom, 11)
            
            Button {
                if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
                }
            } label: {
                CustomButtonView(buttonType: .primary, buttonWidth: 212, buttonLabel: "Ubah Setelan Lokasi", isButtonDisabled: $isButtonDisabled)
            }
        }
        .padding(.horizontal, 84)
    }
}
