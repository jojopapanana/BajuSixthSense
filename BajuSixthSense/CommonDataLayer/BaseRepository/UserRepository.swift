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
            fatalError("No User Found: \(error.localizedDescription)")
        }
        
        return user
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
        
        let minLatitudePredicate = NSPredicate(format: UserFields.Latitude.rawValue + " >= %@", argumentArray: [minLat])
        let maxLatitudePredicate = NSPredicate(format: UserFields.Latitude.rawValue + " <= %@", argumentArray: [maxLat])
        let minLongitudePredicate = NSPredicate(format: UserFields.Longitude.rawValue + " >= %@", argumentArray: [minLon])
        let maxLongitudePredicate = NSPredicate(format: UserFields.Longitude.rawValue + " <= %@", argumentArray: [maxLon])
        let predicate = NSCompoundPredicate(
            andPredicateWithSubpredicates: [minLatitudePredicate, maxLatitudePredicate, minLongitudePredicate, maxLongitudePredicate]
        )
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
        
        queryOperation.queryResultBlock = { returnResult in
            switch returnResult {
                case .success(let returnedCursor):
                    print("Query Succeeded")
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
            record.setValue(param.username, forKey: UserFields.Username.rawValue)
            record.setValue(param.contactInfo, forKey: UserFields.ContactInfo.rawValue)
            record.setValue(param.latitude, forKey: UserFields.Latitude.rawValue)
            record.setValue(param.longitude, forKey: UserFields.Longitude.rawValue)
            record.setValue(param.wardrobe, forKey: UserFields.Wardrobe.rawValue)
            
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
            record.setValue(wardrobe, forKey: UserFields.Wardrobe.rawValue)
            
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

