//
//  UserDTo.swift
//  CloudKitTestProject
//
//  Created by Stevans Calvin Candra on 10/10/24.
//

import Foundation
import CloudKit
import CoreLocation

struct UserDTO {
    var username: String?
    var contactInfo: String?
    var coordinate: CLLocation?
    var wardrobe: [String]?
    var wishlist: [String]?
}

extension UserDTO {
    func prepareRecord() -> CKRecord {
        let record = CKRecord(recordType: RecordName.User.rawValue)
        record.setValue(self.username, forKey: UserFields.Username.rawValue)
        record.setValue(self.contactInfo, forKey: UserFields.ContactInfo.rawValue)
        record.setValue(self.coordinate, forKey: UserFields.Location.rawValue)
        record.setValue(self.wardrobe, forKey: UserFields.Wardrobe.rawValue)
        record.setValue(self.wishlist, forKey: UserFields.WishList.rawValue)
        
        return record
    }
    
    static func mapToEntity(record: CKRecord) -> UserEntity? {
        guard
            let ownerId = record.recordID.recordName as? String,
            let username = record.value(forKey: UserFields.Username.rawValue) as? String,
            let contactInfo = record.value(forKey: UserFields.ContactInfo.rawValue) as? String,
            let coordinate = record.value(forKey: UserFields.Location.rawValue) as? CLLocation,
            let wardrobe = record.value(forKey: UserFields.Wardrobe.rawValue) as? [String],
            let wishlist = record.value(forKey: UserFields.WishList.rawValue) as? [String]
        else { return nil }
        
        return UserEntity(
            userID: ownerId,
            username: username,
            contactInfo: contactInfo,
            coordinate: (coordinate.coordinate.latitude, coordinate.coordinate.longitude),
            wardrobe: wardrobe,
            wishlist: wishlist
        )
    }
}
