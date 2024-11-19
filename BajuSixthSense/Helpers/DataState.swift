//
//  DataState.swift
//  BajuSixthSense
//
//  Created by Stevans Calvin Candra on 11/11/24.
//

import Foundation

enum DataState<T>: Equatable {
    case Initial
    case Loading
    case Success(T)
    case Failure(Error)
    
    var value: T? {
        if case .Success(let retrievedData) = self {
            return retrievedData
        }
        
        return nil
    }
    
    var error: Error? {
        if case .Failure(let receiveError) = self {
            return receiveError
        }
        
        return nil
    }
    
    private var caseIdentifier: Int {
        switch self {
            case .Initial: return 1
            case .Loading: return 2
            case .Success: return 3
            case .Failure: return 4
        }
    }
    
    static func == (lhs: DataState<T>, rhs: DataState<T>) -> Bool {
        return lhs.caseIdentifier == rhs.caseIdentifier
    }
}
