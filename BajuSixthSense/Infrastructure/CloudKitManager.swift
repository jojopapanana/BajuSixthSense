//
//  CloudKitManager.swift
//  BajuSixthSense
//
//  Created by Jovanna Melissa on 07/10/24.
//

import Foundation
import CloudKit

class CloudKitManager {
    static let shared = CloudKitManager()
    
    let container: CKContainer
    let publicDatabase: CKDatabase
    
    init() {
        self.container = CKContainer.default()
        self.publicDatabase = container.publicCloudDatabase
    }
}
