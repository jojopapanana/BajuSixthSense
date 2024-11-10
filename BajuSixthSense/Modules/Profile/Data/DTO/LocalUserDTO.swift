//
//  ProfileEntity.swift
//  BajuSixthSense
//
//  Created by Stevans Calvin Candra on 11/10/24.
//

import Foundation
import CoreLocation

/*
 - ID
 - name
 - contact
 - address
 - coordinate
 - wardrobe = [ClothData]
 - favorites = [UserWardrobe]
 
 
 UserWardrobe:
 - User
 - FavoriteCloth[ClothData]
 */

struct SavedData: Codable {
    var userID: String
    var savedClothes: [String]
}

struct LocalUserDTO: Codable {
    var userID: String?
    var username: String
    var contactInfo: String
    var address: String
    var latitude: Double
    var longitude: Double
    var sugestedMinimal: Int
    var wardrobe: [String]
    var favorite: [SavedData]
    
    init(
        userID: String? = "",
        username: String = "",
        contactInfo: String = "",
        address: String = "",
        latitude: Double = 0,
        longitude: Double = 0,
        sugestedMinimal: Int = 0,
        wardrobe: [String] = [String](),
        favorite: [SavedData] = [SavedData]()
    ) {
        self.userID = userID
        self.username = username
        self.contactInfo = contactInfo
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
        self.sugestedMinimal = sugestedMinimal
        self.wardrobe = wardrobe
        self.favorite = favorite
    }
}

extension LocalUserDTO {
    func mapToUserDTO() -> UserDTO {
        return UserDTO(
            username: self.username,
            contactInfo: self.contactInfo,
            latitude: self.latitude,
            longitude: self.longitude,
            wardrobe: self.wardrobe,
            sugestedMinimal: self.sugestedMinimal
        )
    }
    
    func mapToLocalUserEntity() -> LocalUserEntity {
        return LocalUserEntity(
            userID: self.userID,
            username: self.username,
            contactInfo: self.contactInfo,
            address: self.address,
            coordinate: (lat: self.latitude, lon: self.longitude),
            sugestedMinimal: self.sugestedMinimal
        )
    }
}
