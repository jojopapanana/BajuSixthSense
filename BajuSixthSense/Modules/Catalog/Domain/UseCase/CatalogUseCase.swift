// 
//  CatalogUseCase.swift
//  MacroChallenge
//
//  Created by Stevans Calvin Candra on 01/10/24.
//

import Foundation

protocol CatalogUseCase {
    func fetchCatalogItems(minLat: Double, maxLat: Double, minLon: Double, maxLon: Double) async -> [CatalogItemEntity]
    func addBookmark(bookmark: String) -> Bool
}

final class DefaultCatalogUseCase: CatalogUseCase {
    let udRepo = LocalUserDefaultRepository.shared
    let clothRepo = ClothRepository.shared
    let userRepo = UserRepository.shared
    
    func fetchCatalogItems(minLat: Double, maxLat: Double, minLon: Double, maxLon: Double) async -> [CatalogItemEntity] {
        var items = [CatalogItemEntity]()
        
        let filteredUser: [UserEntity] = await withCheckedContinuation { continuation in
            userRepo.fetchUserByCoordinates(
                maxLat: maxLat,
                minLat: minLat,
                maxLon: maxLon,
                minLon: minLon
            ) { returnedUsers in
                guard let retrievedUsers = returnedUsers else {
                    print("No Users Near You")
                    continuation.resume(returning: [UserEntity]())
                    return
                }
                
                continuation.resume(returning: retrievedUsers)
            }
        }
        
        var clothIDS = [String]()
        
        filteredUser.forEach { user in
            guard let selfUser = udRepo.fetch() else {
                return
            }
            let userID = user.userID ?? ActionFailure.NilStringError.rawValue
            if userID != ActionFailure.NilStringError.rawValue && userID != selfUser.userID {
                clothIDS.append(contentsOf: user.wardrobe)
            }
        }
        
        let retrievedClothes: [ClothEntity] = await withCheckedContinuation { continuation in
            clothRepo.fetchBySelection(ids: clothIDS) { clothes in
                guard let returnedCloth = clothes else {
                    print("No Cloth Found")
                    continuation.resume(returning: [ClothEntity]())
                    return
                }
                
                continuation.resume(returning: returnedCloth)
            }
        }
        
        retrievedClothes.forEach { cloth in
            let userIDX = filteredUser.firstIndex(where: {$0.userID == cloth.id})
            if cloth.status == .Posted {
                items.append(CatalogItemEntity.mapEntitty(cloth: cloth, owner: filteredUser[userIDX ?? 0]))
            }
        }
        
        return items
    }
    
    func fetchCatalogItem(clothID: String) async throws -> CatalogItemEntity {
        guard let cloth = await clothRepo.fetchById(id: clothID) else {
            throw ActionFailure.FailedAction
        }
        
        if cloth.owner.isEmpty {
            throw ActionFailure.FailedAction
        }
        
        guard let owner = await userRepo.fetchUser(id: cloth.owner) else {
            print("nil owner")
            throw ActionFailure.FailedAction
        }
        
        return CatalogItemEntity.mapEntitty(cloth: cloth, owner: owner)
    }
    
    func addBookmark(bookmark: String) -> Bool {
        return udRepo.addBookmarkItem(addedBookmark: bookmark)
    }
    
    func removeBookmark(bookmark: String) -> Bool {
        return udRepo.removeBookmarkItem(removedBookmark: bookmark)
    }
}
