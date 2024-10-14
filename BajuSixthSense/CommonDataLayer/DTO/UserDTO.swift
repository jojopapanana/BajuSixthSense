//
//  UserDTo.swift
//  CloudKitTestProject
//
//  Created by Stevans Calvin Candra on 10/10/24.
//

import Foundation
import CloudKit

struct UserDTO {
    var username: String?
    var contactInfo: String?
    var region: [String]?
    var latitude: Double?
    var longitude: Double?
    var wardrobe: [String]?
}

extension UserDTO {
    func prepareRecord() -> CKRecord {
        let record = CKRecord(recordType: RecordName.User.rawValue)
        record.setValue(self.username, forKey: UserFields.Username.rawValue)
        record.setValue(self.contactInfo, forKey: UserFields.ContactInfo.rawValue)
        record.setValue(self.region, forKey: UserFields.Region.rawValue)
        record.setValue(self.latitude, forKey: UserFields.Latitude.rawValue)
        record.setValue(self.longitude, forKey: UserFields.Longitude.rawValue)
        record.setValue(self.wardrobe, forKey: UserFields.Wardrobe.rawValue)
        
        return record
    }
    
    static func mapToEntity(record: CKRecord) -> UserEntity? {
        guard
            let ownerId = record.recordID.recordName as? String,
            let username = record.value(forKey: UserFields.Username.rawValue) as? String,
            let contactInfo = record.value(forKey: UserFields.ContactInfo.rawValue) as? String,
            let latitude = record.value(forKey: UserFields.Latitude.rawValue) as? Double,
            let longitude = record.value(forKey: UserFields.Longitude.rawValue) as? Double,
            let wardrobe = record.value(forKey: UserFields.Wardrobe.rawValue) as? [String]
        else { return nil }
        
        return UserEntity(
            userID: ownerId,
            username: username,
            contactInfo: contactInfo,
            coordinate: (latitude, longitude),
            wardrobe: wardrobe
        )
    }
}
