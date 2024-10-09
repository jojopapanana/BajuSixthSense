//
//  UploadAdditionalNotesView.swift
//  MacroChallenge
//
//  Created by PadilKeren on 04/10/24.
//

import SwiftUI

struct UploadAdditionalNotesView: View {
    @State private var text: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Additional Notes")
                .font(.custom("Montserrat-SemiBold", size: 17))
                .padding(.horizontal)
            
            Text("Add informations people need to know about your bulk.")
                .padding(.horizontal)
                .font(.system(size: 13))
                .tracking(-0.4)
                .foregroundStyle(Color.gray)
                .lineLimit(1)
            
            Rectangle()
                .frame(width: 350, height: 0.3)
                .foregroundStyle(Color.gray)
                .padding(.horizontal)
                .padding(.bottom, 15)
            
            ZStack(alignment: .topLeading) {
                TextEditor(text: $text)
                    .font(.system(size: 14))
                    .foregroundStyle(Color.black)
                    .padding(.leading, 12)
                    .padding(.top, 4)
                    .frame(width: 350, height: 80)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 1)
                    )
                if text.isEmpty {
                    Text("Stain on some clothes, Open seams on sleeve...")
                        .font(.system(size: 14))
                        .foregroundColor(Color.gray)
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

#Preview {
    UploadAdditionalNotesView()
}
