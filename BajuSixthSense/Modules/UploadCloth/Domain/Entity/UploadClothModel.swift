// 
//  UploadClothModel.swift
//  MacroChallenge
//
//  Created by Stevans Calvin Candra on 01/10/24.
//

import Foundation

struct UploadClothModel: Identifiable {
    var id: String
    var images:[String]
    var clothesType:[String]
    var clothesQty:Int
    var additionalNotes:String?
}
