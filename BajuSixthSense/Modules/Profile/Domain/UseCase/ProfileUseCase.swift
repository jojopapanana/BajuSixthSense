// 
//  ProfileUseCase.swift
//  MacroChallenge
//
//  Created by Stevans Calvin Candra on 01/10/24.
//

import Foundation
import Combine

protocol ProfileUseCase {
    func fetch() -> AnyPublisher<ProfileModel, Error>
}

internal final class DefaultProfileUseCase: ProfileUseCase {
    private let repository: ProfileRepository
    
    init(
        repository: ProfileRepository
    ) {
        self.repository = repository
    }

    func fetch() -> AnyPublisher<ProfileModel, Error> {
        repository.fetch()
    }
}
