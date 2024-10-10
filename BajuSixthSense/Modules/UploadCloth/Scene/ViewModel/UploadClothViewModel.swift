// 
//  UploadClothViewModel.swift
//  MacroChallenge
//
//  Created by Stevans Calvin Candra on 01/10/24.
//

import Foundation

//class UploadClothViewModel:ObservableObject {
//    private let usecase:UploadClothUseCase
//    
//    init(usecase: UploadClothUseCase) {
//        self.usecase = usecase
//    }
//    
//    @Published var selectedImages:[UIImage?] = []
//    @Published var uploadResult:Bool?
//    
//    func upload(images:[UIImage?], clothesType:[String], clothesQty:Int, additionalNotes:String?, status:String){
//        print(selectedImages.count)
//        uploadResult = usecase.save(param: UploadClothParameter(images: selectedImages, clothesType: clothesType, clothesQty: clothesQty, additionalNotes: additionalNotes, status: status))
//    }
//}
//
//extension UploadClothViewModel {
//    enum UploadClothResultData {
//        case initial
//        case success(UploadClothModel)
//        case failure(Error)
//    }
//}
