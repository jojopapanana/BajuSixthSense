//
//  WrappedHStack.swift
//  MacroChallenge
//
//  Created by Stevans Calvin Candra on 06/10/24.
//

import SwiftUI

struct WrappedHStack: Layout {
    var verticalSpacing: CGFloat = 5
    var horizontalSpacing: CGFloat = 5
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        guard !subviews.isEmpty else { return .zero }
        
        let subviewHeight = subviews.map { $0.sizeThatFits(proposal).height }.max() ?? 0
        
        var rowCount: CGFloat = 1
        var widthCount: CGFloat = 0
        var maxWidth: CGFloat = 0
        subviews.forEach { subview in
            if widthCount + subview.sizeThatFits(proposal).width + horizontalSpacing > proposal.width ?? 0 {
                rowCount += 1
                
                if maxWidth < widthCount {
                    maxWidth = widthCount
                }
                
                widthCount = subview.sizeThatFits(proposal).width
            } else {
                widthCount += subview.sizeThatFits(proposal).width + horizontalSpacing
            }
        }
        
        return CGSize(width: max(maxWidth, proposal.width ?? 0), height: (rowCount * subviewHeight) + ((rowCount - 1) * verticalSpacing))
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        guard !subviews.isEmpty else { return }
        
        let height = subviews.map { $0.sizeThatFits(proposal).height }.max() ?? 0
        var x = bounds.minX
        var y = bounds.minY + height/2
        
        subviews.forEach { subview in
            if x + subview.dimensions(in: proposal).width > bounds.maxX {
                x = bounds.minX
                y += height + verticalSpacing
            }
            
            subview.place(
                at: CGPoint(x: x, y: y),
                anchor: .leading,
                proposal: ProposedViewSize(
                    width: subview.dimensions(in: proposal).width,
                    height: subview.dimensions(in: proposal).height
                )
            )
            x += subview.dimensions(in: proposal).width + horizontalSpacing
        }
    }
}
