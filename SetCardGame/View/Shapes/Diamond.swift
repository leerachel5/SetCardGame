//
//  Diamond.swift
//  SetCardGame
//
//  Created by Rachel Lee on 7/13/24.
//

import SwiftUI

struct Diamond: InsettableShape {
    var insetAmount: CGFloat = 0
    
    func path(in rect: CGRect) -> Path {
        let topVertex = CGPoint(x: rect.midX, y: 0)
        let rightVertex = CGPoint(x: rect.maxX, y: rect.midY)
        let bottomVertex = CGPoint(x: rect.midX, y: rect.maxY)
        let leftVertex = CGPoint(x: 0, y: rect.midY)
        
        var path = Path()
        
        path.move(to: topVertex)
        path.addLine(to: rightVertex)
        path.addLine(to: bottomVertex)
        path.addLine(to: leftVertex)
        path.closeSubpath()
        
        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var diamond = self
        diamond.insetAmount += amount
        return diamond
    }
}
