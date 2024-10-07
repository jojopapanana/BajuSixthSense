// 
//  ProfileViewModel.swift
//  MacroChallenge
//
//  Created by Stevans Calvin Candra on 01/10/24.
//

import Foundation
import Combine

internal final class ProfileViewModel {

}

extension ProfileViewModel {
    enum ProfileResultData {
        case initial
        case success(ProfileModel)
        case failure(Error)
    }
}
