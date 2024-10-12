//
//  Extensions.swift
//  MacroChallenge
//
//  Created by Stevans Calvin Candra on 01/10/24.
//

import Foundation
import SwiftUI
import CloudKit

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension UIImage {
    func toCKAsset(name: String? = nil) -> CKAsset? {
        guard let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else {
            return nil
        }

        guard let imageFilePath = NSURL(fileURLWithPath: documentDirectory)
                .appendingPathComponent(name ?? "asset#\(UUID.init().uuidString)")
        else {
            return nil
        }

        do {
            try self.pngData()?.write(to: imageFilePath)
            return CKAsset(fileURL: imageFilePath)
        } catch {
            print("Error converting UIImage to CKAsset!")
        }

        return nil
    }
}

extension UploadNumberOfClothesView{
    func initializeFormatter(formatter: NumberFormatter){
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        formatter.maximumFractionDigits = 0
    }
}

extension ButtonType{
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
            return .systemRed
        }
    }
    
    var textColor : Color{
        if self == .primary{
            return .white
        } else if self == .secondary{
            return .systemPrimary
        } else {
            return .systemRed
        }
    }
}
