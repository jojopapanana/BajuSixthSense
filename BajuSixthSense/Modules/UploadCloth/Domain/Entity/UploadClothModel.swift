// 
//  UploadClothModel.swift
//  MacroChallenge
//
//  Created by Stevans Calvin Candra on 01/10/24.
//

import Foundation
import UIKit

struct UploadClothModel: Identifiable {
    var id: String
    var images:[UIImage?]
    var clothesType:[String]
    var clothesQty:Int
    var additionalNotes:String?
    var status:String
}
