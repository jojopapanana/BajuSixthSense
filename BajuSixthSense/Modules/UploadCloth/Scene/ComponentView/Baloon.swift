//
//  Baloon.swift
//  MacroChallenge
//
//  Created by PadilKeren on 05/10/24.
//

import SwiftUI

struct Baloon: Shape {
    func path(in rect: CGRect) -> Path {
            var path = Path()
            let width = rect.size.width
            let height = rect.size.height
            path.move(to: CGPoint(x: 0.22064*width, y: 0.92127*height))
            path.addCurve(to: CGPoint(x: -0.08131*width, y: 0.72481*height), control1: CGPoint(x: -0.0263*width, y: 0.8823*height), control2: CGPoint(x: -0.08355*width, y: 0.77405*height))
            path.addLine(to: CGPoint(x: 0.02415*width, y: -0.29932*height))
            path.addLine(to: CGPoint(x: 0.38326*width, y: -0.43872*height))
            path.addLine(to: CGPoint(x: 1.18218*width, y: -0.42133*height))
            path.addLine(to: CGPoint(x: 1.25065*width, y: 0.52252*height))
            path.addCurve(to: CGPoint(x: 1.10798*width, y: 0.99754*height), control1: CGPoint(x: 1.22813*width, y: 0.68021*height), control2: CGPoint(x: 1.16806*width, y: 0.99598*height))
            path.addCurve(to: CGPoint(x: 0.77713*width, y: 0.88356*height), control1: CGPoint(x: 1.03289*width, y: 0.99948*height), control2: CGPoint(x: 0.91472*width, y: 0.86888*height))
            path.addCurve(to: CGPoint(x: 0.22064*width, y: 0.92127*height), control1: CGPoint(x: 0.63954*width, y: 0.89825*height), control2: CGPoint(x: 0.52931*width, y: 0.97*height))
            path.closeSubpath()
            return path
        }
}
#Preview {
    Baloon()
}
