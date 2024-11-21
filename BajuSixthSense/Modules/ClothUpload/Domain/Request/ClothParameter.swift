//
//  ClothParameter.swift
//  BajuSixthSense
//
//  Created by Jovanna Melissa on 10/11/24.
//

import Foundation
import SwiftUI

struct ClothParameter: Identifiable{
    var id: String
    var clothImage: UIImage
    var clothType: String
    var clothColor: String
    var clothDefects: [String]?
    var clothDescription: String?
    var clothPrice: Int?
    
    init(id: String, clothImage: UIImage, clothType: String, clothColor: String, clothDefects: [String]? = ["None"], clothDescription: String? = "None", clothPrice: Int? = 0) {
        self.id = id
        self.clothImage = clothImage
        self.clothType = clothType
        self.clothColor = clothColor
        self.clothDefects = clothDefects
        self.clothDescription = clothDescription
        self.clothPrice = clothPrice
    }
}
