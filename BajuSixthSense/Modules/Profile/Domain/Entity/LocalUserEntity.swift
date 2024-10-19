//
//  LocalUserEntity.swift
//  BajuSixthSense
//
//  Created by Stevans Calvin Candra on 12/10/24.
//

import Foundation

struct LocalUserEntity {
    var userID: String?
    var username: String
    var contactInfo: String
    var address: String = "Default Address"
    var coordinate: (lat: Double, lon: Double)
}

extension LocalUserEntity {
    func mapToUser() -> UserEntity {
        return UserEntity(
            userID: self.userID,
            username: self.username,
            contactInfo: self.contactInfo,
            coordinate: self.coordinate,
            wardrobe: [String]())
    }
}
