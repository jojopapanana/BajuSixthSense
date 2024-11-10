// 
//  CatalogUseCase.swift
//  MacroChallenge
//
//  Created by Stevans Calvin Candra on 01/10/24.
//

import Foundation
import Combine

protocol CatalogUseCase {
    func fetchCatalogItems(minLat: Double, maxLat: Double, minLon: Double, maxLon: Double) -> AnyPublisher<[CatalogDisplayEntity]?, Error>
    func addFavorite(owner: String, favorite: String) -> Bool
    func removeFavorite(owner: String, favorite: String) -> Bool
}

final class DefaultCatalogUseCase: CatalogUseCase {
    let udRepo = LocalUserDefaultRepository.shared
    let clothRepo = ClothRepository.shared
    let userRepo = UserRepository.shared
    
    func fetchCatalogItems(minLat: Double, maxLat: Double, minLon: Double, maxLon: Double) -> AnyPublisher<[CatalogDisplayEntity]?, any Error> {
        return Future<[CatalogDisplayEntity]?, Error>{ promise in
            Task {
                var items = [CatalogDisplayEntity]()
                
                let filteredUser: [UserEntity] = await withCheckedContinuation { continuation in
                    self.userRepo.fetchUserByCoordinates(
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
                    guard let selfUser = self.udRepo.fetch() else {
                        return
                    }
                    let userID = user.userID ?? ActionFailure.NilStringError.rawValue
                    if userID != ActionFailure.NilStringError.rawValue && userID != selfUser.userID {
                        clothIDS.append(contentsOf: user.wardrobe)
                    }
                }
                
                let retrievedClothes: [ClothEntity] = await withCheckedContinuation { continuation in
                    self.clothRepo.fetchBySelection(ids: clothIDS) { clothes in
                        guard let returnedCloth = clothes else {
                            print("No Cloth Found")
                            continuation.resume(returning: [ClothEntity]())
                            return
                        }
                        
                        continuation.resume(returning: returnedCloth)
                    }
                }
                
                filteredUser.forEach { user in
                    var clothes = [ClothEntity]()
                    retrievedClothes.forEach { cloth in
                        if cloth.owner == user.userID {
                            clothes.append(cloth)
                        }
                    }
                    
                    items.append(CatalogDisplayEntity(owner: user, distance: nil, clothes: clothes, lowestPrice: nil, highestPrice: nil))
                }
                
                promise(.success(items))
            }
        }
        .eraseToAnyPublisher()
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
    
    func addFavorite(owner: String, favorite: String) -> Bool {
        return udRepo.addFavorite(ownerID: owner, clothID: favorite)
    }
    
    func removeFavorite(owner: String, favorite: String) -> Bool {
        return udRepo.removeFavorite(ownerID: owner, clothID: favorite)
    }
}
