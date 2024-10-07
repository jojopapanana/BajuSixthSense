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
    
    var width = 166.5
    
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
                            .foregroundStyle(.white, .black)
                            .onTapGesture {
                                chosenCloth = nil
                            }
                            .padding(5)
                    }
                    Spacer()
                }
                .frame(width: width)
            } else {
                ZStack {
                    RoundedRectangle(cornerRadius: 2.13)
                        .foregroundColor(.clear)
                        .overlay(
                            RoundedRectangle(cornerRadius: 2.13)
                                .inset(by: 0.43)
                                .stroke(.black, style: StrokeStyle(lineWidth: 0.43, dash: [4.25, 2.13]))
                        )
                    
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
                            .foregroundStyle(.white, .black)
                    }
                }
            }
        }
        .frame(width: width, height: (width/3)*4)
        .clipShape(RoundedRectangle(cornerRadius: 5))
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .inset(by: 1)
                .stroke(.black, lineWidth: chosenCloth == nil ? 0 : 1)
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
            }
        }
    }
}

#Preview {
    PhotoCard()
}
