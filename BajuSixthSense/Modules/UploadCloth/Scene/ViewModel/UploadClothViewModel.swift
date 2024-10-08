// 
//  UploadClothViewModel.swift
//  MacroChallenge
//
//  Created by Stevans Calvin Candra on 01/10/24.
//

import Foundation
import Combine

class UploadClothViewModel:ObservableObject {
    private let usecase:UploadClothUseCase
    
    init(usecase: UploadClothUseCase) {
        self.usecase = usecase
    }
    
    @Published var uploadResult:Bool?
    
    func upload(images:[String], clothesType:[String], clothesQty:Int, additionalNotes:String?){
        uploadResult = usecase.save(param: UploadClothParameter(images: images, clothesType: clothesType, clothesQty: clothesQty, additionalNotes: additionalNotes))
    }
}

extension UploadClothViewModel {
    enum UploadClothResultData {
        case initial
        case success(UploadClothModel)
        case failure(Error)
    }
}
