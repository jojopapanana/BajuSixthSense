// 
//  CatalogUseCase.swift
//  MacroChallenge
//
//  Created by Stevans Calvin Candra on 01/10/24.
//

import Foundation

protocol CatalogUseCase {
    func fetchCatalogItems(regions: [String]) -> [CatalogItemEntity]
}

final class DefaultCatalogUseCase: CatalogUseCase {
    let clothRepo = ClothRepository.shared
    let userRepo = UserRepository.shared
    
    func fetchCatalogItems(regions: [String]) -> [CatalogItemEntity] {
        var items = [CatalogItemEntity]()
        var filteredUser: [UserEntity]?
        
        userRepo.fetchUserByRegion(region: regions) { returnedUsers in
            guard let retrievedUsers = returnedUsers else {
                print("No Users Near You")
                return
            }
            
            filteredUser = retrievedUsers
        }
        
        filteredUser?.forEach { user in
            let userID = user.userID ?? DataError.NilStringError.rawValue
            if userID != DataError.NilStringError.rawValue {
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
