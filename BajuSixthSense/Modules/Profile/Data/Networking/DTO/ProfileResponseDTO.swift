// 
//  ProfileResponseDTO.swift
//  MacroChallenge
//
//  Created by Stevans Calvin Candra on 01/10/24.
//

import Foundation

internal struct ProfileResponseDTO: Decodable {
    
}

extension ProfileResponseDTO {
    func toDomain() -> ProfileModel {
        return .init()
    }
}
