//
//  BookmarkUseCase.swift
//  BajuSixthSense
//
//  Created by Stevans Calvin Candra on 12/10/24.
//

import Foundation
import Combine

protocol FavoriteUseCase {
    func fetchBookmarkedClothes() -> AnyPublisher<[CatalogDisplayEntity]?, Error>
    func addFavorite(owner: String, favorite: String) -> Bool
    func removeFavorite(owner: String, favorite: String) -> Bool
}

final class DefaultFavoriteUseCase: FavoriteUseCase {
    let udRepo = LocalUserDefaultRepository.shared
    let clothRepo = ClothRepository.shared
    let userRepo = UserRepository.shared
    
//    func updateBookMarkChanges(bookmarks: [String]) -> Bool {
//        return udRepo.updateBookmark(bookmark: bookmarks)
//    }
    
//    func removeBookmark(bookmark: String) -> Bool {
//        return udRepo.removeBookmarkItem(removedBookmark: bookmark)
//    }
    
//    func fetchBookmarkIds() -> [String] {
//        guard let user = udRepo.fetch() else { return [] }
//        return user.bookmarks
//    }
    
    func fetchBookmarkedClothes() -> AnyPublisher<[CatalogDisplayEntity]?, Error> {
        return Future<[CatalogDisplayEntity]?, Error> { promise in
            Task {
                guard let user = self.udRepo.fetch() else {
                    return promise(.failure(ActionFailure.NonRegisteredUser))
                }
                
                var items = [CatalogDisplayEntity]()
                var userIDs = [String]()
                
                user.favorite.forEach { data in
                    userIDs.append(data.userID)
                }
                
                let retrievedUsers: [UserEntity] = await withCheckedContinuation { continuation in
                    self.userRepo.fetchUserByIDs(ids: userIDs) { results in
                        guard let retrieveUsers = results else {
                            continuation.resume(returning: [UserEntity]())
                            return
                        }
                        
                        continuation.resume(returning: retrieveUsers)
                    }
                }
                
                for retrievedUser in retrievedUsers {
                    guard let idx = user.favorite.firstIndex(where: { $0.userID == retrievedUser.userID }) else {
                        continue
                    }
                    
                    let clothIDs = user.favorite[idx].savedClothes
                    
                    let retrievedClothes: [ClothEntity] = await withCheckedContinuation { continuation in
                        self.clothRepo.fetchBySelection(ids: clothIDs) { results in
                            guard let retrieveClothes = results else {
                                continuation.resume(returning: [ClothEntity]())
                                return
                            }
                            continuation.resume(returning: retrieveClothes)
                        }
                        
                    }
                    
                    items.append(CatalogDisplayEntity(owner: retrievedUser, distance: nil, clothes: retrievedClothes, lowestPrice: nil, highestPrice: nil))
                }
                
                promise(.success(items))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func addFavorite(owner: String, favorite: String) -> Bool {
        return udRepo.addFavorite(ownerID: owner, clothID: favorite)
    }
    
    func removeFavorite(owner: String, favorite: String) -> Bool {
        return udRepo.removeFavorite(ownerID: owner, clothID: favorite)
    }
}
