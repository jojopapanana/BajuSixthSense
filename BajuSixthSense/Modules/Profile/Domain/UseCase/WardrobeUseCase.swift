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
        var result = false
        result = await clothRepo.delete(id: clothID)
        result = udRepo.removeWardrobeItem(removedWardrobe: clothID)
        
        guard let user = udRepo.fetch() else { return false }
        guard let userID = user.userID else { return false }
        
        result = await userRepo.updateWardrobe(id: userID, wardrobe: user.wardrobe)
        
        return result
    }
    
    /*
     - update cloth (Edit Cloth) -> ClothRepo
     - update status (Edit Cloth Status) -> ClothRepo
     - delete cloth (Delete Cloth) -> ClothRepo & UserRepo & LocalUserRepo
     */
}
