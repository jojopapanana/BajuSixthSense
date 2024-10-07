// 
//  CatalogUseCase.swift
//  MacroChallenge
//
//  Created by Stevans Calvin Candra on 01/10/24.
//

import Foundation
import Combine

protocol CatalogUseCase {
    func fetch() -> AnyPublisher<CatalogModel, Error>
}

internal final class DefaultCatalogUseCase: CatalogUseCase {
    private let repository: CatalogRepository
    
    init(
        repository: CatalogRepository
    ) {
        self.repository = repository
    }

    func fetch() -> AnyPublisher<CatalogModel, Error> {
        repository.fetch()
    }
}
