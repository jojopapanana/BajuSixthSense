//
//  UploadPictureView.swift
//  MacroChallenge
//
//  Created by PadilKeren on 04/10/24.
//

import SwiftUI

struct UploadPictureView: View {
    @State private var isGuideShowing = false
    @State private var showGuideAgain = false
    @State private var isButtonDisabled = true
    var columnLayout: [GridItem] = Array(repeating: GridItem(.fixed(114), spacing: 10, alignment: .center), count: 3)
    
    @EnvironmentObject private var navigationRouter: NavigationRouter
    @StateObject var uploadVM = UploadClothViewModel.shared
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Postingan Baru")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("Posting hingga 10 pakaian")
                .font(.body)
                .foregroundStyle(Color.labelSecondary2)
            
            LazyVGrid(columns: columnLayout, spacing: 23) {
                ForEach(
                    0..<uploadVM.fetchPhoto().count + 1, id: \.self
                ) { index in
                    if(index < 10){
                        PhotoCard(
                            photoIndex: index,
                            isGuideShowing: $isGuideShowing,
                            showGuideAgain: $showGuideAgain,
                            uploadVM: uploadVM
                        )
                    }
                }
            }
            .padding(.top, 16)
            
            Spacer()
            
            Button {
                uploadVM.processClothData(uploadVM.fetchPhoto())
                navigationRouter.push(to: .UploadDetails)
            } label: {
                CustomButtonView(buttonType: .primary, buttonWidth: 361, buttonLabel: "Selanjutnya", isButtonDisabled: $isButtonDisabled)
            }
            .disabled(isButtonDisabled)
            
        }
        .padding([.top, .horizontal])
        .sheet(isPresented: $isGuideShowing) {
            PhotoGuideView(isSheetShowing: $isGuideShowing, showGuideAgain: $showGuideAgain)
                .presentationDetents([.height(528)])
                .presentationDragIndicator(.visible)
        }
        .onChange(of: uploadVM.unprocessedImages.count) { oldValue, newValue in
            if(uploadVM.unprocessedImages.count >= 1){
                isButtonDisabled = false
            } else {
                isButtonDisabled = true
            }
        }
        .navigationTitle("Upload")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            if let guide = LocalUserDefaultRepository().fetch()?.guideShowing{
                showGuideAgain = guide
            }
            
            if(uploadVM.unprocessedImages.count >= 1){
                isButtonDisabled = false
            } else {
                isButtonDisabled = true
            }
        }
        .onChange(of: showGuideAgain) { oldValue, newValue in
            if let guide = LocalUserDefaultRepository.shared.fetch()?.guideShowing{
                showGuideAgain = guide
            }
        }
    }
}

//#Preview {
//    UploadPictureView()
//}
