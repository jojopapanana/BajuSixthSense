//
//  PhotoCard.swift
//  MacroChallenge
//
//  Created by Stevans Calvin Candra on 02/10/24.
//

import SwiftUI
import PhotosUI

struct PhotoCard: View {
    @State var chosenItems: [PhotosPickerItem] = []
    @State var chosenCloth: UIImage?
    @State var galleryUpload: Bool = false
    @State var cameraUpload: Bool = false
    @State var photoIndex = 0
    @Binding var isGuideShowing:Bool
    @Binding var showGuideAgain:Bool
    
    var width = 114.0
    @ObservedObject var uploadVM: UploadClothViewModel
    
    var body: some View {
        ZStack {
            if chosenCloth != nil {
                Image(uiImage: chosenCloth!)
                    .resizable()
                    .scaledToFill()
                    .clipShape(RoundedRectangle(cornerRadius: 2.13))
                
                VStack {
                    HStack {
                        Spacer()
                        Image(systemName: "x.circle.fill")
                            .font(.system(size: 28))
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(Color.systemPureWhite, Color.systemBlack)
                            .onTapGesture {
                                let uploadedCloth = uploadVM.fetchPhoto()
                                
                                guard
                                    let index = uploadedCloth.firstIndex(of: chosenCloth)
                                else {
                                    fatalError("No image found.")
                                }
                                uploadVM.removeImage(index: index)
                            }
                            .padding(5)
                    }
                    Spacer()
                }
                .frame(width: width, height: width)
            } else {
                ZStack {
                    RoundedRectangle(cornerRadius: 1.76)
                        .foregroundColor(Color.clear)
                        .overlay(
                            RoundedRectangle(cornerRadius: 1.76)
                                .inset(by: 0.43)
                                .stroke(Color.systemBlack, style: StrokeStyle(lineWidth: 0.43, dash: [4.25, 2.13]))
                        )
                    
                    Menu {
                        Button {
                            if(!showGuideAgain){
                                cameraUpload.toggle()
                            } else {
                                isGuideShowing = true
                            }
                        } label: {
                            Label("Ambil Foto", systemImage: "camera")
                        }
                        
                        Button {
                            galleryUpload.toggle()
                        } label: {
                            Label("Pilih Foto", systemImage: "photo.on.rectangle")
                        }
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 32))
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.systemPureWhite, .systemBlack)
                    }
                }
            }
        }
        .frame(width: width, height: width)
        .clipShape(RoundedRectangle(cornerRadius: 1.76))
        .overlay(
            RoundedRectangle(cornerRadius: 1.76)
                .stroke(Color.systemBlack, lineWidth: chosenCloth == nil ? 0 : 1)
        )
        .photosPicker(
            isPresented: $galleryUpload,
            selection: $chosenItems,
            maxSelectionCount: 10,
            matching: .any(of: [.images, .screenshots])
        )
        .fullScreenCover(isPresented: $cameraUpload) {
            ImagePicker(uploadVM: uploadVM)
                .ignoresSafeArea()
        }
        .onAppear { 
            if uploadVM.fetchPhoto().count > photoIndex {
                let photos = uploadVM.fetchPhoto()
                chosenCloth = photos[photoIndex]
            } else {
                chosenCloth = nil
            }
        }
        .onChange(of: chosenItems) { oldValue, newValue in
//            chosenItems.removeAll()
            
            Task {
                for item in chosenItems{
                    if let photoItem = try? await item.loadTransferable(type: Data.self) {
                        chosenCloth = UIImage(data: photoItem)
                    }
                    uploadVM.addClothImage(image: chosenCloth)
                }
            }
        }
        .onChange(of: uploadVM.defaultCloth.photos) { oldValue, newValue in
            if uploadVM.fetchPhoto().count > photoIndex {
                let photos = uploadVM.fetchPhoto()
                chosenCloth = photos[photoIndex]
            } else {
                chosenCloth = nil
            }
        }
    }
}

//#Preview {
//    PhotoCard()
//        .disableAction(true)
//}
