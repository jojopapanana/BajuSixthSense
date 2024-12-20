//
//  CloudKitManager.swift
//  BajuSixthSense
//
//  Created by Stevans Calvin Candra on 10/10/24.
//

import Foundation
import CloudKit

protocol UserRepoProtocol {
    func save(param: UserDTO) async -> String
    func fetchUser(id: String) async -> UserEntity?
    func fetchUserByIDs(ids: [String], completion: @escaping ([UserEntity]?) -> Void)
    func fetchUserByCoordinates(maxLat: Double, minLat: Double, maxLon: Double, minLon: Double , completion: @escaping ([UserEntity]?) -> Void)
    func update(id: String, param: UserDTO) async -> Bool
    func updateWardrobe(id: String, wardrobe: [String]) async -> Bool
    func delete(id: String) async -> Bool
}

final class UserRepository: UserRepoProtocol {
    static let shared = UserRepository()
    private let db = CloudKitManager.shared.publicDatabase
    
    func save(param: UserDTO) async -> String {
        var result = ActionFailure.NilStringError.rawValue
        
        do {
            let record = try await db.save(param.prepareRecord())
            result = record.recordID.recordName
            print(result + "  record ID")
        } catch {
            fatalError("Error in saving user data: \(error.localizedDescription)")
        }
        
        return result
    }
    
    func fetchUser(id: String) async -> UserEntity? {
        var user: UserEntity?
        
        do {
            let record = try await db.record(for: CKRecord.ID(recordName: id))
            user = UserDTO.mapToEntity(record: record)
        } catch {
            print("Error in fetchcing: \(id)")
            print("No User Found: \(error.localizedDescription)")
            return user
        }
        
        return user
    }
    
    func fetchUserByIDs(ids: [String], completion: @escaping ([UserEntity]?) -> Void) {
        var users: [UserEntity]?
        var cursor: CKQueryOperation.Cursor?
        
        var recordIDs = [CKRecord.ID]()
        ids.forEach { id in
            recordIDs.append(CKRecord.ID(recordName: id))
        }
        
        let predicate = NSPredicate(format: "recordID IN %@", argumentArray: [recordIDs])
        let query = CKQuery(recordType: RecordName.UserData.rawValue, predicate: predicate)
        let queryOperation = CKQueryOperation(query: query)
        
        queryOperation.recordMatchedBlock = { (recordID, result) in
            switch result {
                case .success(let record):
                    guard let retrieve = UserDTO.mapToEntity(record: record) else {
                        return
                    }
                    if users == nil {
                        users = [UserEntity]()
                    }
                    users?.append(retrieve)
                
                case .failure(let error):
                    print("Error fetching data: \(error.localizedDescription)")
            }
        }
        
        queryOperation.queryResultBlock = { returnResult in
            switch returnResult {
                case .success(let returnedCursor):
                    cursor = returnedCursor
                    completion(users)
                
                case .failure(let error):
                    print("Error querying data: \(error.localizedDescription)")
            }
        }
        
        db.add(queryOperation)
    }
    
    func fetchUserByCoordinates(
        maxLat: Double,
        minLat: Double,
        maxLon: Double,
        minLon: Double,
        completion: @escaping ([UserEntity]?) -> Void
    ) {
        var users: [UserEntity]?
        var cursor: CKQueryOperation.Cursor?
        
        let minLatitudePredicate = NSPredicate(format: UserDataField.Latitude.rawValue + " >= %@", argumentArray: [minLat])
        let maxLatitudePredicate = NSPredicate(format: UserDataField.Latitude.rawValue + " <= %@", argumentArray: [maxLat])
        let minLongitudePredicate = NSPredicate(format: UserDataField.Longitude.rawValue + " >= %@", argumentArray: [minLon])
        let maxLongitudePredicate = NSPredicate(format: UserDataField.Longitude.rawValue + " <= %@", argumentArray: [maxLon])
        let predicate = NSCompoundPredicate(
            andPredicateWithSubpredicates: [minLatitudePredicate, maxLatitudePredicate, minLongitudePredicate, maxLongitudePredicate]
        )
        let query = CKQuery(recordType: RecordName.UserData.rawValue, predicate: predicate)
        let queryOperation = CKQueryOperation(query: query)
        
        queryOperation.recordMatchedBlock = { (recordID, result) in
            switch result {
                case .success(let record):
                    guard let retrieve = UserDTO.mapToEntity(record: record) else {
                        return
                    }
                    if users == nil {
                        users = [UserEntity]()
                    }
                    users?.append(retrieve)
                
                case .failure(let error):
                    print("Error fetching data: \(error.localizedDescription)")
            }
        }
        
        queryOperation.queryResultBlock = { returnResult in
            switch returnResult {
                case .success(let returnedCursor):
                    cursor = returnedCursor
                    completion(users)
                
                case .failure(let error):
                    print("Error querying data: \(error.localizedDescription)")
            }
        }
        
        db.add(queryOperation)
    }
    
    func update(id: String, param: UserDTO) async -> Bool {
        var result = false
        
        do {
            let record = try await db.record(for: CKRecord.ID(recordName: id))
            record.setValue(param.username, forKey: UserDataField.Username.rawValue)
            record.setValue(param.contactInfo, forKey: UserDataField.ContactInfo.rawValue)
            record.setValue(param.latitude, forKey: UserDataField.Latitude.rawValue)
            record.setValue(param.longitude, forKey: UserDataField.Longitude.rawValue)
            record.setValue(param.wardrobe, forKey: UserDataField.Wardrobe.rawValue)
            record.setValue(param.sugestedMinimal, forKey: UserDataField.SugestedMinimal.rawValue)
            
            try await db.save(record)
            result = true
            
            print("Successfully update user")
        } catch {
            fatalError("Failed to update record: \(error.localizedDescription)")
        }
        
        return result
    }
    
    func updateWardrobe(id: String, wardrobe: [String]) async -> Bool {
        var result = false
        
        do {
            let record = try await db.record(for: CKRecord.ID(recordName: id))
            record.setValue(wardrobe, forKey: UserDataField.Wardrobe.rawValue)
            
            try await db.save(record)
            result = true
            
            print("Successfully update user")
        } catch {
            fatalError("Failed to update record: \(error.localizedDescription)")
        }
        
        return result
    }
    
    func delete(id: String) async -> Bool {
        var result = false
        
        do {
            try await db.deleteRecord(withID: CKRecord.ID(recordName: id))
            result = true
            
            print("Successfully delete user")
        } catch {
            fatalError("Failed to delete data: \(error.localizedDescription)")
        }
        
        return result
    }
}

