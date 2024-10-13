//
//  CloudKitManager.swift
//  BajuSixthSense
//
//  Created by Stevans Calvin Candra on 10/10/24.
//

import Foundation
import CloudKit

protocol ClothRepoProtocol {
    func save(param: ClothDTO) -> String
    func fetchAll() -> [ClothEntity]?
    func fetchSpesifyRecord(id: String) -> CKRecord
    func fetchById(id: String) -> ClothEntity?
    func fetchByOwner(id: String) -> [ClothEntity]?
    func update(id: String, param: ClothDTO) -> Bool
    func updateStatus(id: String, status: String) -> Bool
    func delete(id: String) -> Bool
}

final class ClothRepository: ClothRepoProtocol {
    static let shared = ClothRepository()
    private let db = CloudKitManager.shared.publicDatabase
    
    func save(param: ClothDTO) -> String {
        var result = DataError.NilStringError.rawValue
        db.save(param.prepareRecord()) { record, error in
            if let error {
                fatalError("Failed saving data: \(error.localizedDescription)")
            } else {
                print("Successfully saved data")
                guard let id = record?.recordID.recordName else {
                    fatalError("Failed retrieving saved data id")
                }
                
                result = id
            }
        }
        return result
    }
    
    func fetchAll() -> [ClothEntity]? {
        var clothes: [ClothEntity]?
        
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: RecordName.BulkCloth.rawValue, predicate: predicate)
        let queryOperation = CKQueryOperation(query: query)
        
        queryOperation.recordMatchedBlock = { (recordID, result) in
            switch result {
                case .success(let record):
                    print("Successfully fetched data")
                    guard let cloth = ClothDTO.mapToEntity(record: record) else {
                        fatalError("Failed mapping record to entity.")
                    }
                    
                    if clothes == nil {
                        clothes = [ClothEntity]()
                    }
                    clothes?.append(cloth)
                
                case .failure(let error):
                    print("Error fetching data: \(error.localizedDescription)")
            }
        }
        
        db.add(queryOperation)
        
        return clothes
    }
    
    func fetchSpesifyRecord(id: String) -> CKRecord {
        var recordResult: CKRecord?
        
        let recordID = CKRecord.ID(recordName: id)
        let predicate = NSPredicate(format: "recordID=%@", argumentArray: [recordID])
        let query = CKQuery(recordType: RecordName.BulkCloth.rawValue, predicate: predicate)
        let queryOperation = CKQueryOperation(query: query)
        
        queryOperation.recordMatchedBlock = { (recordID, result) in
            switch result {
                case .success(let record):
                    print("Successfully fetched data")
                    recordResult = record
                    
                case .failure(let error):
                    print("Error fetching data: \(error.localizedDescription)")
                
            }
        }
        
        db.add(queryOperation)
        
        return recordResult!
    }
    
    func fetchById(id: String) -> ClothEntity? {
        let clothResult = ClothDTO.mapToEntity(record: fetchSpesifyRecord(id: id))
        
        return clothResult
    }
    
    func fetchByOwner(id: String) -> [ClothEntity]? {
        var clothes: [ClothEntity]?
        
        let predicate = NSPredicate(format: BulkClothFields.OwnerID.rawValue + "=%@", argumentArray: [id])
        let query = CKQuery(recordType: RecordName.BulkCloth.rawValue, predicate: predicate)
        let queryOperation = CKQueryOperation(query: query)
        
        queryOperation.recordMatchedBlock = { (recordID, result) in
            switch result {
                case .success(let record):
                    print("Successfully fetched data")
                    guard let cloth = ClothDTO.mapToEntity(record: record) else {
                        fatalError("Failed to map record to entity")
                    }
                    if clothes == nil {
                        clothes = [ClothEntity]()
                    }
                    clothes?.append(cloth)
                
                case .failure(let error):
                    print("Error fetching data: \(error.localizedDescription)")
            }
        }
        
        db.add(queryOperation)
        
        return clothes
    }
    
    func update(id: String, param: ClothDTO) -> Bool {
        var updateResult: Bool = false
        let record = fetchSpesifyRecord(id: id)
        
        record.setValue(param.ownerID, forKey: BulkClothFields.OwnerID.rawValue)
        record.setValue(param.photos, forKey: BulkClothFields.Photos.rawValue)
        record.setValue(param.quantity, forKey: BulkClothFields.Quantity.rawValue)
        record.setValue(param.categories, forKey: BulkClothFields.Categories.rawValue)
        record.setValue(param.additionalNotes, forKey: BulkClothFields.AdditionalNotes.rawValue)
        record.setValue(param.status, forKey: BulkClothFields.Status.rawValue)
        
        db.save(record) { recordResult, error in
            if let error {
                print("Failed saving data: \(error.localizedDescription)")
                updateResult = false
            } else {
                print("Successfully saved data")
                updateResult = true
            }
        }
        return updateResult
    }
    
    func updateStatus(id: String, status: String) -> Bool {
        var updateResult: Bool = false
        let record = fetchSpesifyRecord(id: id)
        
        record.setValue(status, forKey: BulkClothFields.Status.rawValue)
        
        db.save(record) { recordResult, error in
            if let error {
                print("Failed saving data: \(error.localizedDescription)")
                updateResult = false
            } else {
                print("Successfully saved data")
                updateResult = true
            }
        }
        return updateResult
    }
    
    func delete(id: String) -> Bool {
        var deleteResult: Bool = false
        let recordID = CKRecord.ID(recordName: id)
        
        db.delete(withRecordID: recordID) { deleteRecordId, deleteError in
            print("Delete Successful")
            deleteResult = true
        }
        
        return deleteResult
    }
}
