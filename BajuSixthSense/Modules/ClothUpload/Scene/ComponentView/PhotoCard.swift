//
//  PhotoCard.swift
//  MacroChallenge
//
//  Created by Stevans Calvin Candra on 02/10/24.
//

import SwiftUI
import PhotosUI

struct PhotoCard: View {
    @State var chosenPhoto: PhotosPickerItem?
    @State var chosenCloth: UIImage?
    @State var galleryUpload: Bool = false
    @State var cameraUpload: Bool = false
    @State var minimalPhoto = 0
    
    var width = 166.5
    @ObservedObject var uploadVM: UploadClothViewModel
    
    var body: some View {
        ZStack {
            if chosenCloth != nil {
                Image(uiImage: chosenCloth!)
                    .resizable()
                    .scaledToFill()
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                
                VStack {
                    HStack {
                        Spacer()
                        Image(systemName: "trash.circle.fill")
                            .font(.system(size: 32))
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(Color.systemWhite, Color.systemBlack)
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
                .frame(width: width, height: (width/3)*4)
            } else {
                ZStack {
                    RoundedRectangle(cornerRadius: 2.13)
                        .foregroundColor(Color.clear)
                        .overlay(
                            RoundedRectangle(cornerRadius: 2.13)
                                .inset(by: 0.43)
                                .stroke(Color.systemBlack, style: StrokeStyle(lineWidth: 0.43, dash: [4.25, 2.13]))
                        )
                    
                    if uploadVM.fetchPhoto().count < minimalPhoto {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 32))
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.disabledGreyLabel, .disabledGreyBackground)
                    } else {
                        Menu {
                            Button {
                                cameraUpload.toggle()
                            } label: {
                                Label("Take Photo", systemImage: "camera")
                            }
                            
                            Button {
                                galleryUpload.toggle()
                            } label: {
                                Label("Choose Photo", systemImage: "photo.on.rectangle")
                            }
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .font(.system(size: 32))
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(.systemWhite, .systemBlack)
                        }
                    }
                }
            }
        }
        .frame(width: width, height: (width/3)*4)
        .clipShape(RoundedRectangle(cornerRadius: chosenCloth == nil ? 2.13 : 5))
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .inset(by: 1)
                .stroke(Color.systemBlack, lineWidth: chosenCloth == nil ? 0 : 1)
        )
        .photosPicker(
            isPresented: $galleryUpload,
            selection: $chosenPhoto,
            matching: .any(of: [.images, .screenshots])
        )
        .fullScreenCover(isPresented: $cameraUpload) {
            ImagePicker(chosenImage: $chosenCloth)
                .ignoresSafeArea()
        }
        .onChange(of: chosenPhoto) { oldValue, newValue in
            Task {
                if let photo = try? await chosenPhoto?.loadTransferable(type: Data.self) {
                    chosenCloth = UIImage(data: photo)
                }
                uploadVM.addClothImage(image: chosenCloth)
            }
        }
        .onChange(of: uploadVM.fetchPhoto()) { oldValue, newValue in
            if uploadVM.fetchPhoto().count > minimalPhoto {
                let photos = uploadVM.fetchPhoto()
                chosenCloth = photos[minimalPhoto]
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
