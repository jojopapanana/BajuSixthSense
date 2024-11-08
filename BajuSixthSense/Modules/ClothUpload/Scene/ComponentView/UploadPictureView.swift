//
//  UploadPictureView.swift
//  MacroChallenge
//
//  Created by PadilKeren on 04/10/24.
//

import SwiftUI

struct UploadPictureView: View {
    @State var count = 0
    
    var uploadVM: UploadClothViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Upload Picture")
                .font(.system(size: 17, weight: .semibold))
                .tracking(-0.4)
                .foregroundStyle(Color.systemBlack)
                .padding(.horizontal)
            
            Text("Upload some picture of clothes from your bulk.")
                .font(.system(size: 13))
                .tracking(-0.4)
                .foregroundStyle(Color.labelPrimary)
                .padding(.horizontal)
            
            Divider()
                .frame(width: 350)
                .foregroundStyle(Color.labelPrimary)
                .padding(.horizontal)
                .padding(.bottom, 13)
            
            HStack {
                PhotoCard(minimalPhoto: 0, uploadVM: uploadVM)
                
                VStack {
                    HStack {
                        PhotoCard(minimalPhoto: 1, width: 79.6, uploadVM: uploadVM)
                        PhotoCard(minimalPhoto: 2, width: 79.6, uploadVM: uploadVM)
                    }
                    HStack {
                        PhotoCard(minimalPhoto: 3, width: 79.6, uploadVM: uploadVM)
                        PhotoCard(minimalPhoto: 4, width: 79.6, uploadVM: uploadVM)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

//#Preview {
//    UploadPictureView()
//}
