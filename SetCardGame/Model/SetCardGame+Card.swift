//
//  SetCardGame+Card.swift
//  SetCardGame
//
//  Created by Rachel Lee on 7/13/24.
//

import Foundation

extension SetCardGame {
    struct Card: Hashable, Identifiable, CustomDebugStringConvertible {
        let number: Number
        let shape: Shape
        let shading: Shading
        let color: Color
        
        var id: String // Unique identifier
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
        
        static func == (lhs: Card, rhs: Card) -> Bool {
            return lhs.id == rhs.id
        }
        
        var debugDescription: String {
            "id: \(id), number: \(number), shape: \(shape), shading: \(shading), color: \(color)"
        }
    }
}
