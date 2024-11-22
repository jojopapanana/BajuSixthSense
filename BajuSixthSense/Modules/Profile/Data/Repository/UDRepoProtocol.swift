//
//  UserDefaultRepository.swift
//  BajuSixthSense
//
//  Created by Stevans Calvin Candra on 11/10/24.
//

import Foundation

protocol UDRepoProtocol {
    func save(user: LocalUserDTO) throws
    func fetch() -> LocalUserDTO?
    func addWardrobeItem(addedWardrobe: String) throws
    func removeWardrobeItem(removedWardrobe: String) throws
    func addFavorite(ownerID: String, clothID: String) throws
    func removeFavorite(ownerID: String, clothID: String) throws
    func deleteUser() throws
}

final class LocalUserDefaultRepository: UDRepoProtocol {
    static let shared = LocalUserDefaultRepository()
    
    func save(user: LocalUserDTO) throws {
        do {
            let userData = try JSONEncoder().encode(user)
            UserDefaults.standard.set(userData, forKey: RecordName.UDUserSelf.rawValue)
        } catch {
            throw ActionFailure.FailedAction
        }
    }
    
    func fetch() -> LocalUserDTO? {
        guard
            let userData = UserDefaults.standard.data(forKey: RecordName.UDUserSelf.rawValue)
        else {
            return nil
        }
        let user = try? JSONDecoder().decode(LocalUserDTO.self, from: userData)
        
        return user
    }
    
    func addWardrobeItem(addedWardrobe: String) throws {
        guard var user = fetch() else { return }
        user.wardrobe.append(addedWardrobe)
        do { try save(user: user) } catch {
            throw ActionFailure.FailedAction
        }
    }
    
    func removeWardrobeItem(removedWardrobe: String) throws {
        guard var user = fetch() else { return }
        user.wardrobe.removeAll(where: { $0 == removedWardrobe })
        do { try save(user: user) } catch {
            throw ActionFailure.FailedAction
        }
    }
    
    func fetchFavorite(ownerID: String) -> [String]{
        guard var user = fetch() else { return [] }
        guard let idx = user.favorite.firstIndex(where: { $0.userID == ownerID }) else { return [] }
        
        return user.favorite[idx].savedClothes
    }
    
    func addFavorite(ownerID: String, clothID: String) throws {
        guard var user = fetch() else { return }
        
        guard
            let idx = user.favorite.firstIndex(where: { $0.userID == ownerID })
        else {
            user.favorite.append(SavedData(userID: ownerID, savedClothes: [clothID]))
            do { try save(user: user) } catch {
                throw ActionFailure.FailedAction
            }
            return
        }
        
        user.favorite[idx].savedClothes.append(clothID)
        do { try save(user: user) } catch {
            throw ActionFailure.FailedAction
        }
    }
    
    func removeFavorite(ownerID: String, clothID: String) throws {
        guard var user = fetch() else { return  }
        
        guard
            let idx = user.favorite.firstIndex(where: { $0.userID == ownerID })
        else { throw ActionFailure.FailedAction }
        
        user.favorite[idx].savedClothes.removeAll(where: { $0 == clothID })
        if user.favorite[idx].savedClothes.isEmpty {
            user.favorite.remove(at: idx)
        }
        do { try save(user: user) } catch {
            throw ActionFailure.FailedAction
        }
    }
    
    func saveGuideSetting(willShowAgain: Bool) throws {
        guard var user = fetch() else { return }
        
        user.guideShowing = willShowAgain
        
        do { try save(user: user) } catch {
            throw ActionFailure.FailedAction
        }
    }
    
    func deleteUser() {
        guard var user = fetch() else { return }
        
        user.latitude = 0
        user.longitude = 0
        user.wardrobe.removeAll()
        user.sugestedMinimal = 0
        user.favorite.removeAll()
        user.guideShowing = false
        
        let key = RecordName.UDUserSelf.rawValue
        
        if UserDefaults.standard.object(forKey: key) != nil {
            UserDefaults.standard.removeObject(forKey: key)
            print("User data cleared from UserDefaults.")
        } else {
            print("No user data found in UserDefaults.")
        }
    }
}
