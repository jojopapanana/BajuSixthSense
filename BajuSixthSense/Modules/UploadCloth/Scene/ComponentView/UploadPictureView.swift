//
//  UploadPictureView.swift
//  MacroChallenge
//
//  Created by PadilKeren on 04/10/24.
//

import SwiftUI

struct UploadPictureView: View {
    
//    @StateObject private var vm = UploadClothViewModel(usecase: DefaultUploadClothUseCase(repository: DefaultUploadClothRepository()))
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Upload Picture")
                .font(.custom("Montserrat-SemiBold", size: 20))
                .padding(.horizontal)
            
            Text("Upload some picture of clothes from your bulk.")
                .padding(.horizontal)
                .font(.system(size: 14))
                .tracking(-0.4)
                .foregroundStyle(Color.gray)
            
            Rectangle()
                .frame(width: 350, height: 1)
                .foregroundStyle(Color.gray)
                .padding(.horizontal)
                .padding(.bottom, 15)
            
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

#Preview {
    UploadPictureView()
}
