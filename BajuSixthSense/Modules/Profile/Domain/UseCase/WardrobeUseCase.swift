//
//  WardrobeUseCase.swift
//  BajuSixthSense
//
//  Created by Stevans Calvin Candra on 12/10/24.
//

import Foundation

protocol WardrobeUseCase {
    func editCloth(cloth: ClothEntity) async -> Bool
    func editClothStatus(clothID: String, clothStatus: ClothStatus) async -> Bool
    func deleteCloth(clothID: String) async -> Bool
    func fetchWardrobe() -> [ClothEntity]
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
    
    func fetchWardrobe() -> [ClothEntity] {
        var clothes = [ClothEntity]()
        
        guard let ownerID = udRepo.fetch()?.userID else {
            return clothes
        }
        
        clothRepo.fetchByOwner(id: ownerID) { results in
            guard let retrieveClothes = results else { return }
            clothes.append(contentsOf: retrieveClothes)
        }
        
        return clothes
    }
    
    func getOtherUserWardrobe(userID: String) async -> [ClothEntity] {
        var returnClothes = [ClothEntity]()
        let user = await userRepo.fetchUser(id: userID)
        
        guard let userID = user?.userID else {
            return returnClothes
        }
        
        clothRepo.fetchByOwner(id: userID) { clothes in
            guard let retreiveClothes = clothes else { return }
            returnClothes.append(contentsOf: retreiveClothes)
        }
        
        return returnClothes
    }
}
