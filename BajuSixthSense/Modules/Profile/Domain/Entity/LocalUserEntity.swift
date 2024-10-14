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
