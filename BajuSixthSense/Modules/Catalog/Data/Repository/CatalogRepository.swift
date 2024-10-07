// 
//  CatalogRepository.swift
//  MacroChallenge
//
//  Created by Stevans Calvin Candra on 01/10/24.
//

import Foundation
import Combine

protocol CatalogRepository {
    func fetch() -> AnyPublisher<CatalogModel, Error>
}

internal final class DefaultCatalogRepository: CatalogRepository {
    
    init() { }
    
    func fetch() -> AnyPublisher<CatalogModel, Error> {
        return Future<CatalogModel, Error> { promise in
            promise(.success(.init()))
        }
        .eraseToAnyPublisher()
    }
}
