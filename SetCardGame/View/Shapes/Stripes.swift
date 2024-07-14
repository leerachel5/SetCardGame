//
//  Stripes.swift
//  SetCardGame
//
//  Created by Rachel Lee on 7/13/24.
//

import SwiftUI

struct Stripes: InsettableShape {
    var insetAmount: CGFloat = 0
    
    func path(in rect: CGRect) -> Path {
        let spacing = rect.maxX / 32
        
        var path = Path()
        
        for x in stride(from: 0, through: rect.maxX, by: spacing) {
            path.move(to: CGPoint(x: x, y: 0))
            path.addLine(to: CGPoint(x: x, y: rect.maxY))
        }
        
        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var stripes = self
        stripes.insetAmount += amount
        return stripes
    }
}
