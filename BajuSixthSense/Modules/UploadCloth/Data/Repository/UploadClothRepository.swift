// 
//  UploadClothRepository.swift
//  MacroChallenge
//
//  Created by Stevans Calvin Candra on 01/10/24.
//

import Foundation
import Combine

protocol UploadClothRepository {
    func fetch() -> AnyPublisher<UploadClothModel, Error>
}

internal final class DefaultUploadClothRepository: UploadClothRepository {
    
    init() { }
    
    func fetch() -> AnyPublisher<UploadClothModel, Error> {
        return Future<UploadClothModel, Error> { promise in
            promise(.success(.init()))
        }
        .eraseToAnyPublisher()
    }
}
