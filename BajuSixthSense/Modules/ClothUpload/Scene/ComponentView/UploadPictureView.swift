//
//  UploadPictureView.swift
//  MacroChallenge
//
//  Created by PadilKeren on 04/10/24.
//

import SwiftUI

struct UploadPictureView: View {
//    @ObservedObject var vm:UploadClothViewModel
    
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
                .foregroundStyle(Color.systemGrey1)
                .padding(.horizontal)
            
            Divider()
                .frame(width: 350)
                .foregroundStyle(Color.systemGrey1)
                .padding(.horizontal)
                .padding(.bottom, 13)
            
//            HStack {
//                PhotoCard(viewModel: vm)
//                VStack {
//                    HStack {
//                        PhotoCard(viewModel: vm, width: 79.6)
//                        PhotoCard(viewModel: vm, width: 79.6)
//                    }
//                    HStack {
//                        PhotoCard(viewModel: vm, width: 79.6)
//                        PhotoCard(viewModel: vm, width: 79.6)
//                    }
//                }
//            }
//            .padding(.horizontal)
        }
    }
}

//#Preview {
//    UploadPictureView()
//}
