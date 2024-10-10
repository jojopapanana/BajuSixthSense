//
//  UploadClothParameter.swift
//  BajuSixthSense
//
//  Created by Jovanna Melissa on 07/10/24.
//

import Foundation
import UIKit

struct UploadClothParameter {
    let images:[UIImage?]
    let clothesType:[String]
    let clothesQty:Int
    let additionalNotes:String?
    let status:String
}

extension UploadClothParameter {
    func toRequest() -> UploadClothRequestDTO {
        return .init(
            images: self.images,
            clothesType: self.clothesType,
            clothesQty: self.clothesQty,
            additionalNotes: self.additionalNotes ?? "",
            status: self.status
        )
    }
}
