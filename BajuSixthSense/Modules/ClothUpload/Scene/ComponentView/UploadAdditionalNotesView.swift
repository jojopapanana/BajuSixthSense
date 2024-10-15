//
//  UploadAdditionalNotesView.swift
//  MacroChallenge
//
//  Created by PadilKeren on 04/10/24.
//

import SwiftUI

struct UploadAdditionalNotesView: View {
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Additional Notes")
                .font(.system(size: 17, weight: .semibold))
                .tracking(-0.4)
                .foregroundStyle(Color.systemBlack)
                .padding(.horizontal)
            
            Text("Add informations people need to know about your bulk.")
                .font(.system(size: 13))
                .tracking(-0.4)
                .foregroundStyle(Color.systemGrey1)
                .padding(.horizontal)
            
            Divider()
                .frame(width: 350)
                .foregroundStyle(Color.systemGrey1)
                .padding(.horizontal)
                .padding(.bottom, 13)
            
            ZStack(alignment: .topLeading) {
                TextEditor(text: $text)
                    .font(.system(size: 14))
                    .foregroundStyle(Color.systemBlack)
                    .padding(.leading, 12)
                    .padding(.top, 4)
                    .frame(width: 350, height: 80)
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.systemBlack, lineWidth: 1)
                    )
                if text.isEmpty {
                    Text("Stain on some clothes, Open seams on sleeve...")
                        .font(.system(size: 14))
                        .foregroundColor(Color.systemGrey1)
                        .lineLimit(1)
                        .truncationMode(.tail)
                        .padding(.leading, 16)
                        .padding(.top, 12)
                    
                }
            }
            .padding(.horizontal)
        }
        .contentShape(Rectangle()) // Makes the whole view tappable.
        .onTapGesture {
            self.hideKeyboard()
        }
    }
}

//#Preview {
//    UploadAdditionalNotesView()
//}
