//
//  CloudKitManager.swift
//  BajuSixthSense
//
//  Created by Stevans Calvin Candra on 10/10/24.
//

import Foundation
import CloudKit

protocol ClothRepoProtocol {
    func save(param: ClothDTO) async -> String
    func fetchAll(completion: @escaping ([ClothEntity]?) -> Void)
    func fetchById(id: String) async -> ClothEntity?
    func fetchBySelection(ids: [String], completion: @escaping ([ClothEntity]?) -> Void)
    func fetchByOwner(id: String, completion: @escaping ([ClothEntity]?) -> Void)
    func update(id: String, param: ClothDTO) async -> Bool
    func updateStatus(id: String, status: String) async -> Bool
    func delete(id: String) async -> Bool
}

final class ClothRepository: ClothRepoProtocol {
    static let shared = ClothRepository()
    private let db = CloudKitManager.shared.publicDatabase
    
    func save(param: ClothDTO) async -> String {
        var result = ActionFailure.NilStringError.rawValue
        
        do {
            let record = try await db.save(param.prepareRecord())
            result = record.recordID.recordName
            print(result + "  clothes record ID")
        } catch {
            fatalError("Failed saving data: \(error.localizedDescription)")
        }
        
        return result
    }
    
    func fetchAll(completion: @escaping ([ClothEntity]?) -> Void) {
        var clothes: [ClothEntity]?
        var cursor: CKQueryOperation.Cursor?
        
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: RecordName.ClothItem.rawValue, predicate: predicate)
        let queryOperation = CKQueryOperation(query: query)
        
        queryOperation.recordMatchedBlock = { (recordID, result) in
            switch result {
                case .success(let record):
//                    print("Successfully fetched data")
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
        
        queryOperation.queryResultBlock = { result in
            switch result {
                case .success(let retreiveCursor):
                cursor = retreiveCursor
                completion(clothes)
                
            case .failure(let error):
                print("Error fetching data: \(error.localizedDescription)")
            }
        }
        
        db.add(queryOperation)
    }
    
    func fetchBySelection(ids: [String], completion: @escaping ([ClothEntity]?) -> Void) {
        var clothes: [ClothEntity]?
        var cursor: CKQueryOperation.Cursor?
        
        var recordIDs = [CKRecord.ID]()
        ids.forEach { id in
            recordIDs.append(CKRecord.ID(recordName: id))
        }
        
        let predicate = NSPredicate(format: "recordID IN %@", argumentArray: [recordIDs])
        let query = CKQuery(recordType: RecordName.ClothItem.rawValue, predicate: predicate)
        let queryOperation = CKQueryOperation(query: query)
        
        queryOperation.recordMatchedBlock = { (recordID, result) in
            switch result {
                case .success(let record):
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
        
        queryOperation.queryResultBlock = { result in
            switch result {
                case .success(let retreiveCursor):
                cursor = retreiveCursor
                completion(clothes)
                
            case .failure(let error):
                print("Error fetching data: \(error.localizedDescription)")
            }
        }
        
        db.add(queryOperation)
    }
    
    func fetchById(id: String) async -> ClothEntity? {
        let clothResult : ClothEntity?
        
        do {
            let record = try await db.record(for: CKRecord.ID(recordName: id))
            clothResult = ClothDTO.mapToEntity(record: record)
//            print(record.recordID.recordName)
        } catch {
            fatalError("Error fetching data: \(error.localizedDescription)")
        }
        
        return clothResult
    }
    
    func fetchByOwner(id: String, completion: @escaping ([ClothEntity]?) -> Void) {
        var clothes: [ClothEntity]?
        var cursor: CKQueryOperation.Cursor?
        
        let predicate = NSPredicate(format: ClothItemField.OwnerID.rawValue + "=%@", argumentArray: [id])
        let query = CKQuery(recordType: RecordName.ClothItem.rawValue, predicate: predicate)
        let queryOperation = CKQueryOperation(query: query)
        
        queryOperation.recordMatchedBlock = { (recordID, result) in
            switch result {
                case .success(let record):
                    guard let cloth = ClothDTO.mapToEntity(record: record) else {
                        print("Failed to map record to entity")
                        print("Failure at record: \(record.recordID.recordName)")
                        return
                    }
                    if clothes == nil {
                        clothes = [ClothEntity]()
                    }
                    clothes?.append(cloth)
                
                case .failure(let error):
                    print("Error fetching data: \(error.localizedDescription)")
            }
        }
        
        queryOperation.queryResultBlock = { result in
            switch result {
                case .success(let retreiveCursor):
                cursor = retreiveCursor
                completion(clothes)
                
            case .failure(let error):
                print("Error fetching data: \(error.localizedDescription)")
            }
        }
        
        db.add(queryOperation)
    }
    
    func update(id: String, param: ClothDTO) async -> Bool {
        var updateResult: Bool = false
        
        do {
            let record = try await db.record(for: CKRecord.ID(recordName: id))
            record.setValue(param.ownerID, forKey: ClothItemField.OwnerID.rawValue)
            record.setValue(param.photo, forKey: ClothItemField.Photo.rawValue)
            record.setValue(param.defects, forKey: ClothItemField.Defects.rawValue)
            record.setValue(param.color, forKey: ClothItemField.Color.rawValue)
            record.setValue(param.category, forKey: ClothItemField.Category.rawValue)
            record.setValue(param.description, forKey: ClothItemField.Description.rawValue)
            record.setValue(param.price, forKey: ClothItemField.Price.rawValue)
            record.setValue(param.status, forKey: ClothItemField.Status.rawValue)
            
            try await db.save(record)
            updateResult = true
        } catch {
            fatalError("Failed Updating Data: \(error.localizedDescription)")
        }
        
        return updateResult
    }
    
    func updateStatus(id: String, status: String) async -> Bool {
        var updateResult: Bool = false
        
        do{
            let record = try await db.record(for: CKRecord.ID(recordName: id))
            record.setValue(status, forKey: ClothItemField.Status.rawValue)
            
            try await db.save(record)
            updateResult = true
        } catch {
            fatalError("Failed to update record's status: \(error.localizedDescription)")
        }
            
        return updateResult
    }
    
    func delete(id: String) async -> Bool {
        var deleteResult: Bool = false
        
        do {
            try await db.deleteRecord(withID: CKRecord.ID(recordName: id))
            deleteResult = true
        } catch {
            fatalError("Failed deleting record: \(error.localizedDescription)")
        }
        
        return deleteResult
    }
}
