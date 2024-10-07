// 
//  ChatUseCase.swift
//  MacroChallenge
//
//  Created by Stevans Calvin Candra on 01/10/24.
//

import Foundation
import Combine

protocol ChatUseCase {
    func fetch() -> AnyPublisher<ChatModel, Error>
}

internal final class DefaultChatUseCase: ChatUseCase {
    private let repository: ChatRepository
    
    init(
        repository: ChatRepository
    ) {
        self.repository = repository
    }

    func fetch() -> AnyPublisher<ChatModel, Error> {
        repository.fetch()
    }
}
