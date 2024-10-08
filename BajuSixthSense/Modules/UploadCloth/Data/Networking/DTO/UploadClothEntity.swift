//
//  UploadClothEntity.swift
//  BajuSixthSense
//
//  Created by Jovanna Melissa on 07/10/24.
//

import Foundation
import CloudKit

class UploadClothEntity {
    var id: String
    var images: [String]
    var clothesType: [String]
    var clothesQty: Int
    var additionalNotes: String
    
    init(images:[String], clothesType:[String], clothesQty:Int, additionalNotes:String) {
        self.id = UUID().uuidString
        self.images = images
        self.clothesType = clothesType
        self.clothesQty = clothesQty
        self.additionalNotes = additionalNotes
    }
    
//    func toDomain() -> UploadClothModel {
//        return .init(id: <#String#>, images: <#[String]#>, clothesType: <#[String]#>, clothesQty: <#Int#>)
//    }
}
