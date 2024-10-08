//
//  UploadClothRepository.swift
//  MacroChallenge
//
//  Created by Stevans Calvin Candra on 01/10/24.
//

import Foundation
import CloudKit

protocol UploadClothRepository {
    func save(param: UploadClothRequestDTO) -> Bool?
}

class DefaultUploadClothRepository: UploadClothRepository {
    private let db = CloudKitManager().databasePublic
    
    init() { }
    
    func save(param: UploadClothRequestDTO) -> Bool? {
        var result: Bool = false
        let record = CKRecord(recordType: "Bulk")
        record.setValue(param.images, forKey: "images")
        record.setValue(param.clothesType, forKey: "clothesType")
        record.setValue(param.clothesQty, forKey: "clothesQty")
        record.setValue(param.additionalNotes, forKey: "additionalNotes")
        
        db.save(record) { (savedRecord, error) in
            if error == nil {
                print("Record Saved")
                result = true
            } else {
                print("Record Not Saved, \(error)")
                result = false
            }
        }
        return result
    }
}
