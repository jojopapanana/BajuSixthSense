//
//  CloudKitManager.swift
//  BajuSixthSense
//
//  Created by Stevans Calvin Candra on 10/10/24.
//

import Foundation
import CloudKit

protocol UserRepoProtocol {
    func save(param: UserDTO) -> String
    func fetchRecord(id: String) -> CKRecord
    func fetchUser(id: String) -> UserEntity?
    func fetchUserByRegion(region: [String]) -> [UserEntity]?
    func update(id: String, param: UserDTO) -> Bool
    func delete(id: String) -> Bool
}

final class UserRepository: UserRepoProtocol {
    static let shared = UserRepository()
    private let db = CloudKitManager.shared.publicDatabase
    
    func save(param: UserDTO) -> String {
        var result = DataError.NilStringError.rawValue
        
        db.save(param.prepareRecord()) { record, error in
            if let error {
                fatalError("Error in saving user data: \(error.localizedDescription)")
            } else {
                print("User data saved successfully")
                guard let id = record?.recordID.recordName else {
                    fatalError("Failed retrieving saved data id")
                }
                
                result = id
            }
        }
        
        return result
    }
    
    func fetchRecord(id: String) -> CKRecord {
        var recordResult: CKRecord?
        
        let recordID = CKRecord.ID(recordName: id)
        let predicate = NSPredicate(format: "recordID=%@", argumentArray: [recordID])
        let query = CKQuery(recordType: RecordName.User.rawValue, predicate: predicate)
        let queryOperation = CKQueryOperation(query: query)
        
        queryOperation.recordMatchedBlock = { (recordID, result) in
            switch result {
                case .success(let record):
                    print("Fetch Succeeded")
                    recordResult = record
                
                case .failure(let error):
                    print("Error fetching data: \(error.localizedDescription)")
                
            }
        }
        
        db.add(queryOperation)
        
        return recordResult!
    }
    
    func fetchUser(id: String) -> UserEntity? {
        var user = UserDTO.mapToEntity(record: fetchRecord(id: id))
        
        return user
    }
    
    func fetchUserByRegion(region: [String]) -> [UserEntity]? {
        var users: [UserEntity]?
        
        let predicate = NSPredicate(format: UserFields.Region.rawValue + "=%@", argumentArray: region)
        let query = CKQuery(recordType: RecordName.User.rawValue, predicate: predicate)
        let queryOperation = CKQueryOperation(query: query)
        
        queryOperation.recordMatchedBlock = { (recordID, result) in
            switch result {
                case .success(let record):
                    print("Fetch Succeeded")
                    guard let retrieve = UserDTO.mapToEntity(record: record) else {
                        fatalError("Retrieving User")
                    }
                    if users == nil {
                        users = [UserEntity]()
                    }
                    users?.append(retrieve)
                
                case .failure(let error):
                    print("Error fetching data: \(error.localizedDescription)")
            }
        }
        
        db.add(queryOperation)
        
        return users
    }
    
    func update(id: String, param: UserDTO) -> Bool {
        var result = false
        var record = fetchRecord(id: id)
        
        record.setValue(param.username, forKey: UserFields.Username.rawValue)
        record.setValue(param.contactInfo, forKey: UserFields.ContactInfo.rawValue)
        record.setValue(param.coordinate, forKey: UserFields.Location.rawValue)
        record.setValue(param.wardrobe, forKey: UserFields.Wardrobe.rawValue)
        
        db.save(record) { record, error in
            if let error {
                print("Error in saving user data: \(error.localizedDescription)")
                result = false
            } else {
                print("User data saved successfully")
                result = true
            }
            
        }
        
        return result
    }
    
    func updateWardrobe(id: String, wardrobe: [String]) -> Bool {
        var result = false
        var record = fetchRecord(id: id)
        record.setValue(wardrobe, forKey: UserFields.Wardrobe.rawValue)
        
        db.save(record) { record, error in
            if let error {
                print("Error in saving user data: \(error.localizedDescription)")
                result = false
            } else {
                print("User data saved successfully")
                result = true
            }
        }
        
        return result
    }
    
    func delete(id: String) -> Bool {
        var result = false
        var recordID = CKRecord.ID(recordName: id)
        
        db.delete(withRecordID: recordID) { record, error in
            print("User data deleted successfully")
            result = true
        }
        
        return result
    }
}

