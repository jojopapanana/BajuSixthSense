//
//  CatalogCardModel.swift
//  BajuSixthSense
//
//  Created by PadilKeren on 10/10/24.
//

import SwiftUI

// cuma ngetes
// UNUSED

struct CatalogCardModel: Identifiable {
    var id: String
    var image: String
}

var CatalogCardModels: [CatalogCardModel] = [
    .init(id: "1", image: "Image1"),
    .init(id: "2", image: "Image2"),
    .init(id: "3", image: "Image3"),
    .init(id: "4", image: "Image4"),
]
