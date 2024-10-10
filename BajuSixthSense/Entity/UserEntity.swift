//
//  UserEntity.swift
//  CloudKitTestProject
//
//  Created by Stevans Calvin Candra on 10/10/24.
//

import Foundation

struct UserEntity {
    var userID: String?
    var username: String
    var contactInfo: String
    var address: String = "Default Address"
    var coordinate: (lat: Double, lon: Double)
    var wardrobe: [String]
    var wishlist: [String]
    
    init(userID: String?, username: String, contactInfo: String, coordinate: (lat: Double, lon: Double), wardrobe: [String], wishlist: [String]) {
        self.userID = userID
        self.username = username
        self.contactInfo = contactInfo
        self.coordinate = coordinate
        self.wardrobe = wardrobe
        self.wishlist = wishlist
    }
}
