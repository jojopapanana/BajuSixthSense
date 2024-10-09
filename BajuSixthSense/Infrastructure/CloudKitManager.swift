//
//  CloudKitManager.swift
//  BajuSixthSense
//
//  Created by Jovanna Melissa on 07/10/24.
//

import Foundation
import CloudKit

class CloudKitManager: ObservableObject {
  let container: CKContainer
  let databasePublic: CKDatabase

  init() {
    self.container = CKContainer.default()
    self.databasePublic = container.publicCloudDatabase
  }
}
