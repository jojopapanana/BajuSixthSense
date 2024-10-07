// 
//  CatalogResponseDTO.swift
//  MacroChallenge
//
//  Created by Stevans Calvin Candra on 01/10/24.
//

import Foundation

internal struct CatalogResponseDTO: Decodable {
    
}

extension CatalogResponseDTO {
    func toDomain() -> CatalogModel {
        return .init()
    }
}
