// 
//  UploadClothResponseDTO.swift
//  MacroChallenge
//
//  Created by Stevans Calvin Candra on 01/10/24.
//

import Foundation

internal struct UploadClothResponseDTO: Decodable {
    
}

extension UploadClothResponseDTO {
    func toDomain() -> UploadClothModel {
        return .init()
    }
}
