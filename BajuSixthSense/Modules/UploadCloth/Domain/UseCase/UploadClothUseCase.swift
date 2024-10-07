// 
//  UploadClothUseCase.swift
//  MacroChallenge
//
//  Created by Stevans Calvin Candra on 01/10/24.
//

import Foundation
import Combine

protocol UploadClothUseCase {
    func fetch() -> AnyPublisher<UploadClothModel, Error>
}

internal final class DefaultUploadClothUseCase: UploadClothUseCase {
    private let repository: UploadClothRepository
    
    init(
        repository: UploadClothRepository
    ) {
        self.repository = repository
    }

    func fetch() -> AnyPublisher<UploadClothModel, Error> {
        repository.fetch()
    }
}
