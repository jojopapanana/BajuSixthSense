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
    var latitude: Double?
    var longitude: Double?
    var wardrobe: [String]?
    var sugestedMinimal: Int?
}

extension UserDTO {
    func prepareRecord() -> CKRecord {
        let record = CKRecord(recordType: RecordName.UserData.rawValue)
        record.setValue(self.username, forKey: UserDataField.Username.rawValue)
        record.setValue(self.contactInfo, forKey: UserDataField.ContactInfo.rawValue)
        record.setValue(self.latitude, forKey: UserDataField.Latitude.rawValue)
        record.setValue(self.longitude, forKey: UserDataField.Longitude.rawValue)
        record.setValue(self.wardrobe, forKey: UserDataField.Wardrobe.rawValue)
        record.setValue(self.sugestedMinimal, forKey: UserDataField.SugestedMinimal.rawValue)
        
        return record
    }
    
    static func mapToEntity(record: CKRecord) -> UserEntity? {
        guard
            let ownerId = record.recordID.recordName as? String,
            let username = record.value(forKey: UserDataField.Username.rawValue) as? String,
            let contactInfo = record.value(forKey: UserDataField.ContactInfo.rawValue) as? String,
            let latitude = record.value(forKey: UserDataField.Latitude.rawValue) as? Double,
            let longitude = record.value(forKey: UserDataField.Longitude.rawValue) as? Double,
            let wardrobe = record.value(forKey: UserDataField.Wardrobe.rawValue) as? [String],
            let minimal = record.value(forKey: UserDataField.SugestedMinimal.rawValue) as? Int
        else { return nil }
        
        return UserEntity(
            userID: ownerId,
            username: username,
            contactInfo: contactInfo,
            coordinate: (latitude, longitude),
            wardrobe: wardrobe,
            minimal: minimal
        )
    }
}
