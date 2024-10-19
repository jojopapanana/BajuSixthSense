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
            return .systemPrimary
        } else if self == .secondary{
            return .clear
        } else {
            return .systemWhite
        }
    }
    
    var strokeColor : Color{
        if self == .primary{
            return .disabledGreyBackground
        } else if self == .secondary{
            return .systemPrimary
        } else {
            return .systemRedApp
        }
    }
    
    var textColor : Color{
        if self == .primary{
            return .white
        } else if self == .secondary{
            return .systemPrimary
        } else {
            return .systemRedApp
        }
    }
}
