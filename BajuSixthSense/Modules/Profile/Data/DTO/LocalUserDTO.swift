//
//  ProfileEntity.swift
//  BajuSixthSense
//
//  Created by Stevans Calvin Candra on 11/10/24.
//

import Foundation
import CoreLocation

struct LocalUserDTO: Codable {
    var userID: String?
    var username: String
    var contactInfo: String
    var address: String
    var latitude: Double
    var longitude: Double
    var wardrobe: [String]
    var bookmarks: [String]
    
    init(
        userID: String? = "",
        username: String = "",
        contactInfo: String = "",
        address: String = "",
        latitude: Double = 0,
        longitude: Double = 0,
        wardrobe: [String] = [String](),
        bookmarks: [String] = [String]()
    ) {
        self.userID = userID
        self.username = username
        self.contactInfo = contactInfo
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
        self.wardrobe = wardrobe
        self.bookmarks = bookmarks
    }
}

extension LocalUserDTO {
    func mapToUserDTO() -> UserDTO {
        return UserDTO(
            username: self.username,
            contactInfo: self.contactInfo,
            latitude: self.latitude,
            longitude: self.longitude,
            wardrobe: self.wardrobe
        )
    }
    
    func mapToLocalUserEntity() -> LocalUserEntity {
        return LocalUserEntity(
            userID: self.userID,
            username: self.username,
            contactInfo: self.contactInfo,
            address: self.address,
            coordinate: (lat: self.latitude, lon: self.longitude)
        )
    }
}
