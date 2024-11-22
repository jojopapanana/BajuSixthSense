//
//  Extensions.swift
//  MacroChallenge
//
//  Created by Stevans Calvin Candra on 01/10/24.
//

import Foundation
import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension UIImage {
    func optimizeScaling() -> UIImage {
        let oriWidth = self.size.width
        let oriHeight = self.size.height
        var size = CGSize(width: 400, height: 400)
        
        if oriHeight > oriWidth {
            size = CGSize(width: (400*oriWidth)/oriHeight, height: 400)
        } else if oriHeight == oriWidth {
            var size = CGSize(width: 400, height: 400)
        } else {
            size = CGSize(width: 400, height: (400*oriHeight)/oriWidth)
        }
        
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
