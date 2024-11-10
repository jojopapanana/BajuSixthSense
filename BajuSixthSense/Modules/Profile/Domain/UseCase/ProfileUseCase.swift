// 
//  ProfileUseCase.swift
//  MacroChallenge
//
//  Created by Stevans Calvin Candra on 01/10/24.
//

import Foundation
import Combine

protocol ProfileUseCase {
    func updateProfile(profile: LocalUserEntity) async -> Bool
    func fetchUser(id: String) -> AnyPublisher<UserEntity?, Error>
    func fetchSelfUser() throws -> LocalUserEntity
    func checkUserRegistration() -> Bool
    func fetchSelfData() -> LocalUserDTO
}

final class DefaultProfileUseCase: ProfileUseCase {
    let udRepo = LocalUserDefaultRepository.shared
    let userRepo = UserRepository.shared
    
    func updateProfile(profile: LocalUserEntity) async -> Bool {
        var result = false
        
        guard var user = udRepo.fetch() else { return false }
        user.username = profile.username
        user.contactInfo = profile.contactInfo
        user.address = profile.address
        user.latitude = profile.coordinate.lat
        user.longitude = profile.coordinate.lon
        
        guard let id = user.userID else { return false }
        
        result = udRepo.save(user: user)
        result = await userRepo.update(id: id, param: user.mapToUserDTO())
        
        return result
    }
    
    func fetchUser(id: String) -> AnyPublisher<UserEntity?, Error> {
        return Future<UserEntity?, Error> { promise in
            Task {
                guard let user = await self.userRepo.fetchUser(id: id) else {
                    return promise(.failure(ActionFailure.NoDataFound))
                }
                promise(.success(user))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func fetchSelfUser() throws -> LocalUserEntity {
        guard let user = udRepo.fetch() else {
            throw ActionFailure.NonRegisteredUser
        }
        
        return user.mapToLocalUserEntity()
    }
    
    func checkUserRegistration() -> Bool {
        guard let user = udRepo.fetch() else {
            return false
        }
        
        return true
    }
    
    func fetchSelfData() -> LocalUserDTO {
        guard let user = udRepo.fetch() else {
            return LocalUserDTO()
        }
        
        return user
    }
}
