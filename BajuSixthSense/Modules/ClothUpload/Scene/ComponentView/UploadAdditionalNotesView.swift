//
//  UploadAdditionalNotesView.swift
//  MacroChallenge
//
//  Created by PadilKeren on 04/10/24.
//

import SwiftUI

struct UploadAdditionalNotesView: View {
    @State var notes = ""
    @ObservedObject var uploadVM: UploadClothViewModel
    
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
                .foregroundStyle(Color.labelPrimary)
                .padding(.horizontal)
            
            Divider()
                .frame(width: 350)
                .foregroundStyle(Color.labelPrimary)
                .padding(.horizontal)
                .padding(.bottom, 13)
            
            ZStack(alignment: .topLeading) {
                TextEditor(text: $notes)
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
                if uploadVM.defaultCloth.additionalNotes.isEmpty {
                    Text("Stain on some clothes, Open seams on sleeve...")
                        .font(.system(size: 14))
                        .foregroundColor(Color.labelPrimary)
                        .lineLimit(1)
                        .truncationMode(.tail)
                        .padding(.leading, 16)
                        .padding(.top, 12)
                    
                }
            }
            .padding(.horizontal)
            .onChange(of: notes) { oldValue, newValue in
                uploadVM.defaultCloth.additionalNotes = notes
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            self.hideKeyboard()
        }
        .onAppear {
            if !uploadVM.defaultCloth.additionalNotes.isEmpty {
                notes = uploadVM.defaultCloth.additionalNotes
            }
        }
    }
}

//#Preview {
//    UploadAdditionalNotesView()
//}
