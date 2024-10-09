//
//  UploadClothEntity.swift
//  BajuSixthSense
//
//  Created by Jovanna Melissa on 07/10/24.
//

import Foundation
import CloudKit
import UIKit

class UploadClothEntity {
    var id: String
    var images: [UIImage?]
    var clothesType: [String]
    var clothesQty: Int
    var additionalNotes: String
    var status: String
    
    init(images:[UIImage?], clothesType:[String], clothesQty:Int, additionalNotes:String, status:String) {
        self.id = UUID().uuidString
        self.images = images
        self.clothesType = clothesType
        self.clothesQty = clothesQty
        self.additionalNotes = additionalNotes
        self.status = status
    }
    
//    func toDomain() -> UploadClothModel {
//        return .init(id: <#String#>, images: <#[String]#>, clothesType: <#[String]#>, clothesQty: <#Int#>)
//    }
}
