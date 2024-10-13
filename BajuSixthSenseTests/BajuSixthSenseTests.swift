//
//  BajuSixthSenseTests.swift
//  BajuSixthSenseTests
//
//  Created by Jovanna Melissa on 07/10/24.
//

import Testing
import XCTest
import SwiftUI
@testable import BajuSixthSense

struct BajuSixthSenseTests {

    @Test
    func test() {
        let a = 10
        #expect(a == 10, "Not Equal")
    }
    
    @Test
    func uploadCloth() {
        Task {
            let uploadUseCase = DefaultUploadClothUseCase()
            let udRepo = LocalUserDefaultRepository.shared
            let userRepo = UserRepository.shared
            let owner = udRepo.fetch()
            
            guard let id = owner?.username else {
                Issue.record("No Owner Found")
                return
            }
            
            let cloth = ClothEntity(
                clothID: nil,
                owner: id,
                photos: [UIImage(named:"BusinessHappyHandsUp")!, UIImage(named: "DefaultHappyHandsUp")!],
                quantity: 2,
                category: [ClothType.Pants],
                additionalNotes: "Test",
                lastUpdated: Date.now,
                status: ClothStatus.Available
            )
            
            let recordID = await uploadUseCase.saveNewCloth(cloth: cloth)
            let userWardrobelcl = udRepo.fetch()?.wardrobe
            print(userWardrobelcl?.first ?? "Nil")
            
            let user = await userRepo.fetchUser(id: id)
            let userWardrobe = user?.wardrobe
            print(userWardrobe?.first ?? "Nil")
            
            #expect(recordID != DataError.NilStringError.rawValue, "Record ID should not be nil")
            #expect(userWardrobe != nil && userWardrobelcl != nil, "User Wardrobe should not be nil")
            #expect(userWardrobe == userWardrobelcl, "Different saving")
        }
    }
    
    @Test
    func uploadClothDraft() {
        //TODO: double check the logic
    }
    
    @Test
    func discoverCatalogItem() {
        let usecase = DefaultCatalogUseCase()
        let catalog = usecase.fetchCatalogItems(regions: ["Tangerang"])
        print(catalog.count)
        
        #expect(catalog.count == 2, "Should have 2 catalog items")
    }
    
    @Test
    func editCloth() {
        Task {
            let id = "D2347DC7-5E35-4E11-A4EC-81E97EAEE58B"
            let usecase = DefaultWardrobeUseCase()
            let cloth = ClothEntity(
                clothID: id,
                owner: "padil_keren",
                photos: [UIImage(named:"BusinessHappyHandsUp")!, UIImage(named: "DefaultHappyHandsUp")!],
                quantity: 2,
                category: [.Pants, .Hat],
                additionalNotes: "",
                lastUpdated: Date.now,
                status: .Damaged
            )
            
            let result = await usecase.editCloth(cloth: cloth)
            
            #expect(result, "Should be successful")
        }
    }
    
    @Test
    func updateClothStatus() {
        Task {
            let id = "D2347DC7-5E35-4E11-A4EC-81E97EAEE58B"
            let usecase = DefaultWardrobeUseCase()
            let result = await usecase.editClothStatus(clothID: id, clothStatus: ClothStatus.Lost)
            
            #expect(result, "Should be successful")
        }
    }
    
    @Test
    func deleteCloth() {
        Task {
            let usecase = DefaultWardrobeUseCase()
            let result = await usecase.deleteCloth(clothID: "51E62EDB-3588-4892-8DD4-E315F0EC1FAC")
            
            #expect(result, "Should be successful")
        }
    }
    
    @Test
    func editProfile() {
        Task {
            let user = LocalUserDefaultRepository.shared.fetch()
            
            guard var entity = user?.mapToLocalUserEntity() else {
                fatalError("no user")
            }
            entity.username = "PanPan"
            
            let usecase = DefaultProfileUseCase()
            let result = await usecase.updateProfile(profile: entity)
            
            #expect(result, "Should be successful")
        }
    }

    @Test
    func bookmarkCloth() {
        let id = "8A8F4422-ACA2-4012-8088-ECC0DB74794F"
        let usecase = DefaultBookmarkUseCase()
        let result = usecase.addBookmark(bookmark: id)
        
        let ud = LocalUserDefaultRepository.shared
        guard let user = ud.fetch() else {
            fatalError("no user")
        }
        
        let resultBookmarked = user.bookmarks.contains(id)
        
        #expect(result, "Should be successful")
        #expect(resultBookmarked, "Should be bookmarked")
    }
    
    @Test
    func deleteBookmark() {
        let id = "8A8F4422-ACA2-4012-8088-ECC0DB74794F"
        let usecase = DefaultBookmarkUseCase()
        let result = usecase.removeBookmark(bookmark: id)
        
        let ud = LocalUserDefaultRepository.shared
        guard let user = ud.fetch() else {
            fatalError("no user")
        }
        
        let resultBookmarked = user.bookmarks.contains(id)
        
        #expect(result, "Should be successful")
        #expect(!resultBookmarked, "Should not be bookmarked")
    }
    
}
