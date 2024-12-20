//
//  WardrobeUseCase.swift
//  BajuSixthSense
//
//  Created by Stevans Calvin Candra on 12/10/24.
//

import Foundation
import Combine

protocol WardrobeUseCase {
    func editCloth(cloth: ClothEntity) async throws
    func editClothStatus(clothID: String, clothStatus: ClothStatus) async throws
    func deleteCloth(clothID: String) async throws
    func fetchWardrobe() -> AnyPublisher<[ClothEntity]?, Error>
    func getOtherUserWardrobe(userID: String) -> AnyPublisher<[ClothEntity]?, Error>
}

final class DefaultWardrobeUseCase: WardrobeUseCase {
    let clothRepo = ClothRepository.shared
    let userRepo = UserRepository.shared
    let udRepo = LocalUserDefaultRepository.shared
    
    func editCloth(cloth: ClothEntity) async throws {
        guard let clothId = cloth.id else { throw ActionFailure.FailedAction }
        let status = await clothRepo.update(id: clothId, param: cloth.mapToDTO())
        if !status { throw ActionFailure.FailedAction }
    }
    
    func editClothStatus(clothID: String, clothStatus: ClothStatus) async throws {
        let status = await clothRepo.updateStatus(id: clothID, status: clothStatus.rawValue)
        if !status { throw ActionFailure.FailedAction }
    }
    
    func deleteCloth(clothID: String) async throws {
        var result = await clothRepo.delete(id: clothID)
        if !result { throw ActionFailure.FailedAction }
        
        do {
            try udRepo.removeWardrobeItem(removedWardrobe: clothID)
            
            guard
                let user = udRepo.fetch(),
                let userID = user.userID
            else {
                throw ActionFailure.FailedAction
            }
            
            result = await userRepo.updateWardrobe(id: userID, wardrobe: user.wardrobe)
            if !result { throw ActionFailure.FailedAction }
        } catch {
            throw ActionFailure.FailedAction
        }
    }
    
    func fectchWardrobeData() -> [String] {
        guard let user = udRepo.fetch() else { return [] }
        
        return user.wardrobe
    }
    
    func fetchWardrobe() -> AnyPublisher<[ClothEntity]?, Error> {
        return Future<[ClothEntity]?, Error> { promise in
            Task {
                guard let ownerID = self.udRepo.fetch()?.userID else {
                    return promise(.failure(ActionFailure.NonRegisteredUser))
                }
                
                let retrievedClothes: [ClothEntity] = await withCheckedContinuation { continuation in
                    self.clothRepo.fetchByOwner(id: ownerID) { results in
                        guard let returnedClothes = results else {
                            continuation.resume(returning: [ClothEntity]())
                            return
                        }
                        continuation.resume(returning: returnedClothes)
                    }
                }
                
                promise(.success(retrievedClothes))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func getOtherUserWardrobe(userID: String) -> AnyPublisher<[ClothEntity]?, Error> {
        return Future<[ClothEntity]?, Error> { promise in
            Task {
                let user = await self.userRepo.fetchUser(id: userID)
                
                guard let userID = user?.userID else {
                    return promise(.failure(ActionFailure.NoDataFound))
                }
                
                let othersClothes: [ClothEntity] = await withCheckedContinuation { continuation in
                    self.clothRepo.fetchByOwner(id: userID) { clothes in
                        guard let retreiveClothes = clothes else {
                            continuation.resume(returning: [ClothEntity]())
                            return
                        }
                        continuation.resume(returning: retreiveClothes)
                    }
                }
                
                promise(.success(othersClothes))
            }
        }
        .eraseToAnyPublisher()
    }
}
