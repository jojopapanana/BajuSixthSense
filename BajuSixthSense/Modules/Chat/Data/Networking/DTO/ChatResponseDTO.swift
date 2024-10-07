// 
//  ChatResponseDTO.swift
//  MacroChallenge
//
//  Created by Stevans Calvin Candra on 01/10/24.
//

import Foundation

internal struct ChatResponseDTO: Decodable {
    
}

extension ChatResponseDTO {
    func toDomain() -> ChatModel {
        return .init()
    }
}
