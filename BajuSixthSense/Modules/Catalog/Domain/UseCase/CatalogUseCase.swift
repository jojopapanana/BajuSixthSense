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
        var filteredCloth: [ClothEntity]?
        
        guard let retrievedUsers = userRepo.fetchUserByRegion(region: regions) else {
            print("No Users Near You")
            return items
        }
        
        filteredUser = retrievedUsers
        filteredUser?.forEach { user in
            let userID = user.userID ?? DataError.NilStringError.rawValue
            if userID != DataError.NilStringError.rawValue {
                let retrievedClothes = clothRepo.fetchByOwner(id: userID)
                
                retrievedClothes?.forEach { cloth in
                    items.append(CatalogItemEntity.mapEntitty(cloth: cloth, owner: user))
                }
            }
        }
        
        return items
    }
}
