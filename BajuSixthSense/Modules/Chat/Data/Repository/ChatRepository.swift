// 
//  ChatRepository.swift
//  MacroChallenge
//
//  Created by Stevans Calvin Candra on 01/10/24.
//

import Foundation
import Combine

protocol ChatRepository {
    func fetch() -> AnyPublisher<ChatModel, Error>
}

internal final class DefaultChatRepository: ChatRepository {
    
    init() { }
    
    func fetch() -> AnyPublisher<ChatModel, Error> {
        return Future<ChatModel, Error> { promise in
            promise(.success(.init()))
        }
        .eraseToAnyPublisher()
    }
}
