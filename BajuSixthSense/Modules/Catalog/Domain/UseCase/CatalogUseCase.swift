// 
//  CatalogUseCase.swift
//  MacroChallenge
//
//  Created by Stevans Calvin Candra on 01/10/24.
//

import Foundation

protocol CatalogUseCase {
    func fetchCatalogItems(minLat: Double, maxLat: Double, minLon: Double, maxLon: Double) -> [CatalogItemEntity]
}

final class DefaultCatalogUseCase: CatalogUseCase {
    let clothRepo = ClothRepository.shared
    let userRepo = UserRepository.shared
    
    func fetchCatalogItems(minLat: Double, maxLat: Double, minLon: Double, maxLon: Double) -> [CatalogItemEntity] {
        var items = [CatalogItemEntity]()
        var filteredUser: [UserEntity]?
        
        userRepo.fetchUserByCoordinates(maxLat: maxLat, minLat: minLat, maxLon: maxLon, minLon: minLon) { returnedUsers in
            guard let retrievedUsers = returnedUsers else {
                print("No Users Near You")
                return
            }
            
            filteredUser = retrievedUsers
        }
        
        filteredUser?.forEach { user in
            let userID = user.userID ?? ActionFailure.NilStringError.rawValue
            if userID != ActionFailure.NilStringError.rawValue {
                clothRepo.fetchByOwner(id: userID) { returnedClothes in
                    guard let clothes = returnedClothes else {
                        return
                    }
                    
                    clothes.forEach { cloth in
                        items.append(CatalogItemEntity.mapEntitty(cloth: cloth, owner: user))
                    }
                }
            }
        }
        
        return items
    }
}
