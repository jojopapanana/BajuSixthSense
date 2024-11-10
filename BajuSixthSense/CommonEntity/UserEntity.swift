//
//  UserEntity.swift
//  CloudKitTestProject
//
//  Created by Stevans Calvin Candra on 10/10/24.
//

import Foundation

/*
 - ID
 - name
 - contact
 - address
 - coordinate
 - wardrobe = [ClothData]
 - saranPengambilanBaju
 */

struct UserEntity: Equatable {
    var userID: String?
    var username: String
    var contactInfo: String
    var address: String = "Default Address"
    var coordinate: (lat: Double, lon: Double)
    var wardrobe: [String]
    var sugestedMinimal: Int
    
    init(
        userID: String?,
        username: String,
        contactInfo: String,
        coordinate: (lat: Double, lon: Double),
        wardrobe: [String],
        minimal: Int
    ) {
        self.userID = userID
        self.username = username
        self.contactInfo = contactInfo
        self.coordinate = coordinate
        self.wardrobe = wardrobe
        self.sugestedMinimal = minimal
    }
    
    static func == (lhs: UserEntity, rhs: UserEntity) -> Bool {
        let idCheck = lhs.userID == rhs.userID
        let usernameCheck = lhs.username == rhs.username
        let contactInfoCheck = lhs.contactInfo == rhs.contactInfo
        let addressCheck = lhs.address == rhs.address
        let coordinateCheck = lhs.coordinate == rhs.coordinate
        let wardrobeCheck = lhs.wardrobe == rhs.wardrobe
        let minimalCheck = lhs.sugestedMinimal == rhs.sugestedMinimal
        
        return idCheck && usernameCheck && contactInfoCheck && addressCheck && coordinateCheck && wardrobeCheck && minimalCheck
    }
}
