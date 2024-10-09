// 
//  UploadClothRequestDTO.swift
//  MacroChallenge
//
//  Created by Stevans Calvin Candra on 01/10/24.
//

import Foundation
import UIKit

struct UploadClothRequestDTO {
    var images:[UIImage?]
    var clothesType:[String]
    var clothesQty:Int
    var additionalNotes:String?
    var status:String
}
