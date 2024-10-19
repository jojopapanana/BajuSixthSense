// 
//  UploadClothUseCase.swift
//  MacroChallenge
//
//  Created by Stevans Calvin Candra on 01/10/24.
//

import Foundation

protocol UploadClothUseCase {
    func saveNewCloth(cloth: ClothEntity) async -> String
}

final class DefaultUploadClothUseCase: UploadClothUseCase {
    let clothRepo = ClothRepository.shared
    let userRepo = UserRepository.shared
    let udRepo = LocalUserDefaultRepository.shared
    
    func saveNewCloth(cloth: ClothEntity) async -> String {
        guard
            let user = udRepo.fetch(),
            let id = user.userID
        else {
            return ActionFailure.NilStringError.rawValue
        }
        
        var clothItem = cloth
        clothItem.owner = id
        
        let recordId = await clothRepo.save(param: clothItem.mapToDTO())
        
        if recordId == ActionFailure.NilStringError.rawValue {
            return recordId
        }
        
        if udRepo.addWardrobeItem(addedWardrobe: recordId) {
            print("Successfully add wardrobe item to User Default")
        }
        
        guard let wardrobe = udRepo.fetch()?.wardrobe else {
            return recordId
        }
        
        let updateResult = await userRepo.updateWardrobe(id: clothItem.owner, wardrobe: wardrobe)
        
        if updateResult {
            print("Sucessfully update wardrobe database")
        }
        
        return recordId
    }
}
