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
    func updateWardrobe(wardrobe: [String]) -> Bool
    func updateBookmark(bookmark: [String]) -> Bool
    func addWardrobeItem(addedWardrobe: String) -> Bool
    func removeWardrobeItem(removedWardrobe: String) -> Bool
    func addBookmarkItem(addedBookmark: String) -> Bool
    func removeBookmarkItem(removedBookmark: String) -> Bool
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
            fatalError("Failed Reading Data")
        }
        let user = try? JSONDecoder().decode(LocalUserDTO.self, from: userData)
        
        return user
    }
    
    func updateWardrobe(wardrobe: [String]) -> Bool {
        guard var user = fetch() else { return false }
        
        user.wardrobe = wardrobe
        return save(user: user)
    }
    
    func updateBookmark(bookmark: [String]) -> Bool {
        guard var user = fetch() else { return false }
        
        user.bookmarks = bookmark
        return save(user: user)
    }
    
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
    
    func addBookmarkItem(addedBookmark: String) -> Bool {
        guard var user = fetch() else { return false }
        
        user.bookmarks.append(addedBookmark)
        return save(user: user)
    }
    
    func removeBookmarkItem(removedBookmark: String) -> Bool {
        guard var user = fetch() else { return false }
        
        user.bookmarks.removeAll(where: { $0 == removedBookmark })
        return save(user: user)
    }
}
