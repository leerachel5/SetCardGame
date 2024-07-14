//
//  Card.swift
//  SetCardGame
//
//  Created by Rachel Lee on 7/13/24.
//

import SwiftUI

struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
    let number: Number
    let shape: Shape
    let shading: Shading
    let color: Color
    
    var id: String
    var debugDescription: String {
        "id: \(id), number: \(number), shape: \(shape), shading: \(shading), color: \(color)"
    }
    
    enum Number: Int, CaseIterable {
        case one = 1
        case two = 2
        case three = 3
    }
    
    enum Shape: CaseIterable {
        case diamond
        case squiggle
        case oval
    }
    
    enum Shading: CaseIterable {
        case solid
        case striped
        case open
    }
    
    enum Color: String, CaseIterable {
        case red
        case green
        case purple
        
        var rawColor: SwiftUI.Color {
            let colors: [Color: SwiftUI.Color] = [.red: .red, .green: .green, .purple: .purple]
            return colors[self]!
        }
    }
}
