//
//  Diamond.swift
//  SetCardGame
//
//  Created by Rachel Lee on 7/13/24.
//

import SwiftUI
import CoreGraphics

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        let topVertex = CGPoint(x: rect.midX, y: 0)
        let rightVertex = CGPoint(x: rect.maxX, y: rect.midY)
        let bottomVertex = CGPoint(x: rect.midX, y: rect.maxY)
        let leftVertex = CGPoint(x: 0, y: rect.midY)
        
        var p = Path()
        
        p.move(to: topVertex)
        p.addLine(to: rightVertex)
        p.addLine(to: bottomVertex)
        p.addLine(to: leftVertex)
        p.closeSubpath()
        
        return p
    }
}

