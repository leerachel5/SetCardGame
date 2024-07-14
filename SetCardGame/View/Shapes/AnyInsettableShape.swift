//
//  AnyInsettableShape.swift
//  SetCardGame
//
//  Created by Rachel Lee on 7/14/24.
//

import SwiftUI


/**
 A type-erased InsettableShape value
 
 You can use this type to dynamically switch between Shape types and have these Shapes conform to the InsettableShape protocol.
 */
struct AnyInsettableShape: InsettableShape {
    
    private let _shape: AnyShape
    var insetAmount: CGFloat
    
    init<S: Shape>(_ shape: S, inset: CGFloat = 0) {
        _shape = AnyShape(shape)
        insetAmount = inset
    }
    
    func path(in rect: CGRect) -> Path {
        return _shape.path(in: rect)
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var newInsetShape = self
        newInsetShape.insetAmount += amount
        return newInsetShape
    }
}
