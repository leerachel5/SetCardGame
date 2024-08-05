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
        
        var state: State = .unselected
        var partition: Partition
        
        var id: String // Unique identifier
        
        enum State: CaseIterable {
            case unselected
            case selected
            case successfulMatch
            case unsuccessfulMatch
        }
        
        enum Partition: CaseIterable {
            case discarded
            case faceUp
            case inDeck
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
        
        var debugDescription: String {
            "id: \(id), number: \(number), shape: \(shape), shading: \(shading), color: \(color)"
        }
    }
}
