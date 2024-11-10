//
//  WardrobeUseCase.swift
//  BajuSixthSense
//
//  Created by Stevans Calvin Candra on 12/10/24.
//

import Foundation
import Combine

protocol WardrobeUseCase {
    func editCloth(cloth: ClothEntity) async -> Bool
    func editClothStatus(clothID: String, clothStatus: ClothStatus) async -> Bool
    func deleteCloth(clothID: String) async -> Bool
    func fetchWardrobe() -> AnyPublisher<[ClothEntity]?, Error>
    func getOtherUserWardrobe(userID: String) -> AnyPublisher<[ClothEntity]?, Error>
}

final class DefaultWardrobeUseCase: WardrobeUseCase {
    let clothRepo = ClothRepository.shared
    let userRepo = UserRepository.shared
    let udRepo = LocalUserDefaultRepository.shared
    
    func editCloth(cloth: ClothEntity) async -> Bool {
        guard let clothId = cloth.id else { return false }
        let status = await clothRepo.update(id: clothId, param: cloth.mapToDTO())
        return status
    }
    
    func editClothStatus(clothID: String, clothStatus: ClothStatus) async -> Bool {
        let status = await clothRepo.updateStatus(id: clothID, status: clothStatus.rawValue)
        return status
    }
    
    func deleteCloth(clothID: String) async -> Bool {
        var result = await clothRepo.delete(id: clothID)
        
        if !result {
            return false
        }
        
        if udRepo.removeWardrobeItem(removedWardrobe: clothID) {
            guard let user = udRepo.fetch() else { return false }
            guard let userID = user.userID else { return false }
            
            result = await userRepo.updateWardrobe(id: userID, wardrobe: user.wardrobe)
        } else {
            return false
        }
        
        return result
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
                var returnedClothes = [ClothEntity]()
                let user = await self.userRepo.fetchUser(id: userID)
                
                guard let userID = user?.userID else {
                    return promise(.failure(ActionFailure.NoDataFound))
                }
                
                self.clothRepo.fetchByOwner(id: userID) { clothes in
                    guard let retreiveClothes = clothes else { return }
                    returnedClothes.append(contentsOf: retreiveClothes)
                }
                
                promise(.success(returnedClothes))
            }
        }
        .eraseToAnyPublisher()
    }
}
