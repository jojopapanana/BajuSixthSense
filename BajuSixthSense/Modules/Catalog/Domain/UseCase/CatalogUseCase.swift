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
    func addFavorite(owner: String, favorite: String) throws
    func removeFavorite(owner: String, favorite: String) throws
    func fetchCloth(id: String) async -> ClothEntity?
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
                        guard var retrievedUsers = returnedUsers else {
                            print("No Users Near You")
                            continuation.resume(returning: [UserEntity]())
                            return
                        }
                        
                        guard
                            let selfUser = self.udRepo.fetch(),
                            let idx = retrievedUsers.firstIndex(where: { $0.userID == selfUser.userID })
                        else {
                            continuation.resume(returning: [UserEntity]())
                            return }
                        retrievedUsers.remove(at: idx)
                        
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
    
    func addFavorite(owner: String, favorite: String) throws {
        do { try udRepo.addFavorite(ownerID: owner, clothID: favorite) } catch {
            throw ActionFailure.FailedAction
        }
    }
    
    func removeFavorite(owner: String, favorite: String) throws {
        do { try udRepo.removeFavorite(ownerID: owner, clothID: favorite) } catch {
            throw ActionFailure.FailedAction
        }
    }
    
    func fetchCloth(id: String) async -> ClothEntity? {
        return await clothRepo.fetchById(id: id)
    }
}
