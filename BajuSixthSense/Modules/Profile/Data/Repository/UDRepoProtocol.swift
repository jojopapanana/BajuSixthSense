//
//  UserDefaultRepository.swift
//  BajuSixthSense
//
//  Created by Stevans Calvin Candra on 11/10/24.
//

import Foundation

protocol UDRepoProtocol {
    func save(user: LocalUserDTO) -> Bool
    func fetch() -> LocalUserDTO?
//    func updateWardrobe(wardrobe: [String]) -> Bool
    func addWardrobeItem(addedWardrobe: String) -> Bool
    func removeWardrobeItem(removedWardrobe: String) -> Bool
//    func updateBookmark(bookmark: [String]) -> Bool
    func addFavorite(ownerID: String, clothID: String) -> Bool
    func removeFavorite(ownerID: String, clothID: String) -> Bool
}

final class LocalUserDefaultRepository: UDRepoProtocol {
    static let shared = LocalUserDefaultRepository()
    
    func save(user: LocalUserDTO) -> Bool {
        do {
            let userData = try JSONEncoder().encode(user)
            UserDefaults.standard.set(userData, forKey: RecordName.UDUserSelf.rawValue)
            return true
        } catch {
            fatalError("Failed Saving Data: \(error.localizedDescription)")
        }
    }
    
    func fetch() -> LocalUserDTO? {
        guard let userData = UserDefaults.standard.data(forKey: RecordName.UDUserSelf.rawValue) else {
            return nil
        }
        let user = try? JSONDecoder().decode(LocalUserDTO.self, from: userData)
        
        return user
    }
    
//    func updateWardrobe(wardrobe: [String]) -> Bool {
//        guard var user = fetch() else { return false }
//        
//        user.wardrobe = wardrobe
//        return save(user: user)
//    }
    
//    func updateBookmark(bookmark: [String]) -> Bool {
//        guard var user = fetch() else { return false }
//        
//        user.bookmarks = bookmark
//        return save(user: user)
//    }
    
    func addWardrobeItem(addedWardrobe: String) -> Bool {
        guard var user = fetch() else { return false }
        
        user.wardrobe.append(addedWardrobe)
        return save(user: user)
    }
    
    func removeWardrobeItem(removedWardrobe: String) -> Bool {
        guard var user = fetch() else { return false }
        
        user.wardrobe.removeAll(where: { $0 == removedWardrobe })
        return save(user: user)
    }
    
    func addFavorite(ownerID: String, clothID: String) -> Bool {
        guard var user = fetch() else { return false }
        
        guard let idx = user.favorite.firstIndex(where: { $0.userID == ownerID }) else {
            user.favorite.append(SavedData(userID: ownerID, savedClothes: [clothID]))
            return save(user: user)
        }
        user.favorite[idx].savedClothes.append(clothID)
        
        return save(user: user)
    }
    
    func removeFavorite(ownerID: String, clothID: String) -> Bool {
        guard var user = fetch() else { return false }
        
        guard let idx = user.favorite.firstIndex(where: { $0.userID == ownerID }) else {
            return false
        }
        
        user.favorite[idx].savedClothes.removeAll(where: { $0 == clothID })
        if user.favorite[idx].savedClothes.isEmpty {
            user.favorite.remove(at: idx)
        }
        
        return save(user: user)
    }
}
