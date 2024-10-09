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
        var assets: [CKAsset] = []
        let record = CKRecord(recordType: "Bulk")
        
        record.setValue(param.clothesType, forKey: "clothesType")
        record.setValue(param.clothesQty, forKey: "clothesQty")
        record.setValue(param.additionalNotes, forKey: "additionalNotes")
        for image in param.images{
            if let asset = image!.toCKAsset() {
                assets.append(asset)
                print("Succeed to turn image into asset")
            } else {
                print("Failed to turn image into asset")
            }
        }
        record["images"] = assets
        record.setValue("Uploaded", forKey: "status")
        
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
