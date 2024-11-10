//
//  Extensions.swift
//  MacroChallenge
//
//  Created by Stevans Calvin Candra on 01/10/24.
//

import Foundation
import SwiftUI

extension ButtonType {
    var fill : Color{
        if self == .primary{
            return .systemPurple
        } else if self == .secondary{
            return .clear
        } else {
            return .systemPureWhite
        }
    }
    
    var strokeColor : Color {
        if self == .primary {
            return .labelPrimary
        } else if self == .secondary {
            return .systemPurple
        } else {
            return .systemError
        }
    }
    
    var textColor : Color {
        if self == .primary {
            return .white
        } else if self == .secondary {
            return .systemPurple
        } else {
            return .systemError
        }
    }
}
