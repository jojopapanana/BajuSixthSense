//
//  WardrobeUseCase.swift
//  BajuSixthSense
//
//  Created by Stevans Calvin Candra on 12/10/24.
//

import Foundation

protocol WardrobeUseCase {
    func editCloth(cloth: ClothEntity) -> Bool
    func editClothStatus(clothID: String, clothStatus: ClothStatus) -> Bool
    func deleteCloth(clothID: String, userId: String, wardrobeItems: [String]) -> Bool
}

final class DefaultWardrobeUseCase: WardrobeUseCase {
    let clothRepo = ClothRepository.shared
    let userRepo = UserRepository.shared
    let udRepo = LocalUserDefaultRepository.shared
    
    func editCloth(cloth: ClothEntity) -> Bool {
        guard let clothId = cloth.id else { return false }
        return clothRepo.update(id: clothId, param: cloth.mapToDTO())
    }
    
    func editClothStatus(clothID: String, clothStatus: ClothStatus) -> Bool {
        return clothRepo.updateStatus(id: clothID, status: clothStatus.rawValue)
    }
    
    func deleteCloth(clothID: String, userId: String, wardrobeItems: [String]) -> Bool {
        var result = false
        result = clothRepo.delete(id: clothID)
        result = userRepo.updateWardrobe(id: userId, wardrobe: wardrobeItems)
        result = udRepo.removeWardrobeItem(removedWardrobe: clothID)
        
        return result
    }
    
    /*
     - update cloth (Edit Cloth) -> ClothRepo
     - update status (Edit Cloth Status) -> ClothRepo
     - delete cloth (Delete Cloth) -> ClothRepo & UserRepo & LocalUserRepo
     */
}
