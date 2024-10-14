// 
//  UploadClothViewModel.swift
//  MacroChallenge
//
//  Created by Stevans Calvin Candra on 01/10/24.
//

import Foundation
import SwiftUI

class UploadClothViewModel:ObservableObject {
    private let usecase: UploadClothUseCase
    
    init(usecase: UploadClothUseCase) {
        self.usecase = usecase
    }
    
    @Published var selectedImages: [UIImage?] = []
    @Published var uploadResult: String?
    
    func upload(images:[UIImage?], clothesType:[String], clothesQty:Int, additionalNotes:String?, status:String) {
        print(selectedImages.count)
//        uploadResult = usecase.save(param: UploadClothParameter(images: selectedImages, clothesType: clothesType, clothesQty: clothesQty, additionalNotes: additionalNotes, status: status))
        
        Task {
            guard let ownerID = LocalUserDefaultRepository.shared.fetch()?.userID else { return }
            
            var types = [ClothType]()
            clothesType.forEach { type in
                types.append(ClothType.assignType(type: type))
            }
            
            uploadResult = await usecase
                .saveNewCloth(
                    cloth: ClothEntity(
                        clothID: nil,
                        owner: ownerID,
                        photos: images,
                        quantity: clothesQty,
                        category: types,
                        additionalNotes: additionalNotes ?? "",
                        lastUpdated: Date.now,
                        status: ClothStatus.assignStatus(status: status)
                    )
                )
        }
    }
}

extension UploadClothViewModel {
    enum UploadClothResultData {
        case initial
        case success(ClothEntity)
        case failure(Error)
    }
}
