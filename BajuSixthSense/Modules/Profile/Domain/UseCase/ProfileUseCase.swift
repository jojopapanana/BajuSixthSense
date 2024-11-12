// 
//  ProfileUseCase.swift
//  MacroChallenge
//
//  Created by Stevans Calvin Candra on 01/10/24.
//

import Foundation
import Combine

protocol ProfileUseCase {
    func updateProfile(profile: LocalUserEntity) async throws
    func fetchUser(id: String) -> AnyPublisher<UserEntity?, Error>
    func fetchSelfUser() throws -> LocalUserEntity
    func checkUserRegistration() -> Bool
    func fetchSelfData() -> LocalUserDTO
    
    //TODO:
    // - Add Fetched Shared Cloth Logic
    // - Add Cart Handling Logic
}

final class DefaultProfileUseCase: ProfileUseCase {
    let udRepo = LocalUserDefaultRepository.shared
    let userRepo = UserRepository.shared
    
    func updateProfile(profile: LocalUserEntity) async throws {
        guard var user = udRepo.fetch() else { return }
        user.username = profile.username
        user.contactInfo = profile.contactInfo
        user.address = profile.address
        user.latitude = profile.coordinate.lat
        user.longitude = profile.coordinate.lon
        
        guard let id = user.userID else { return }
        do { try udRepo.save(user: user) } catch {
            throw ActionFailure.FailedAction
        }
        
        let result = await userRepo.update(id: id, param: user.mapToUserDTO())
        if !result { throw ActionFailure.FailedAction }
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
        guard udRepo.fetch() != nil else {
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
    
    //    func fetchSharedCatalogItem(clothID: String) async throws -> CatalogItemEntity {
    //        guard let cloth = await clothRepo.fetchById(id: clothID) else {
    //            throw ActionFailure.FailedAction
    //        }
    //
    //        if cloth.owner.isEmpty {
    //            throw ActionFailure.FailedAction
    //        }
    //
    //        guard let owner = await userRepo.fetchUser(id: cloth.owner) else {
    //            print("nil owner")
    //            throw ActionFailure.FailedAction
    //        }
    //
    //        return CatalogItemEntity.mapEntitty(cloth: cloth, owner: owner)
    //    }
}
