//
//  BajuSixthSenseTests.swift
//  BajuSixthSenseTests
//
//  Created by Jovanna Melissa on 07/10/24.
//

import Testing
import SwiftUI
@testable import BajuSixthSense

/*
UserRepository()
    .save(param:
            UserDTO(username: "Jo", contactInfo: "333333333", coordinate: CLLocation(latitude: 0.0, longitude: 0.0), wardrobe: ["clth1", "clth2"]))

ClothRepository()
    .save(param:
            ClothEntity(
                clothID: nil,
                owner: "pans123",
                photos: [UIImage(named:"BusinessHappyHandsUp")!, UIImage(named: "DefaultHappyHandsUp")!],
                quantity: 2,
                category: [.Pants, .Hat],
                additionalNotes: "",
                lastUpdated: Date.now,
                status: .Damaged
            )
                .mapToDTO()
    )
 */

struct BajuSixthSenseTests {

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
            
            #expect(recordID != DataError.NilStringError.rawValue, "Record ID should not be nil")
//            #expect(<#T##condition: Bool##Bool#>)
        }
    }
    
    @Test
    func uploadClothDraft() {
        
    }
    
    @Test
    func discoverCatalogItem() {
        
    }
    
    @Test
    func editCloth() {
        
    }
    
    @Test
    func updateClothStatus() {
        
    }
    
    @Test
    func deleteCloth() {
        
    }
    
    @Test
    func editProfile() {
        
    }

    @Test
    func bookmarkCloth() {
        
    }
    
    @Test
    func deleteBookmark() {
        
    }
    
}
