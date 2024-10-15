//
//  BookmarkUseCase.swift
//  BajuSixthSense
//
//  Created by Stevans Calvin Candra on 12/10/24.
//

import Foundation

protocol BookmarkUseCase {
    func updateBookMarkChanges(bookmarks: [String]) -> Bool
    func addBookmark(bookmark: String) -> Bool
    func removeBookmark(bookmark: String) -> Bool
}

final class DefaultBookmarkUseCase: BookmarkUseCase {
    let udRepo = LocalUserDefaultRepository.shared
    
    func updateBookMarkChanges(bookmarks: [String]) -> Bool {
        return udRepo.updateBookmark(bookmark: bookmarks)
    }
    
    func addBookmark(bookmark: String) -> Bool {
        return udRepo.addBookmarkItem(addedBookmark: bookmark)
    }
    
    func removeBookmark(bookmark: String) -> Bool {
        return udRepo.removeBookmarkItem(removedBookmark: bookmark)
    }
}
