//
//  ClassicSetCardGame+Feature.swift
//  SetCardGame
//
//  Created by Rachel Lee on 8/4/24.
//

import SwiftUI

extension ClassicSetCardGame {
    
    enum Number: Int, SetCardGameFeature.Number {
        case one = 1
        case two = 2
        case three = 3
    }
    
    enum Shape: SetCardGameFeature.Shape {
        case diamond
        case squiggle
        case oval
        
        var insettableShape: AnyInsettableShape {
            switch self {
            case .diamond:
                return AnyInsettableShape(Diamond())
            case .oval:
                return AnyInsettableShape(Oval())
            case .squiggle:
                return AnyInsettableShape(Squiggle())
            }
        }
    }
    
    enum Shading: SetCardGameFeature.Shading {
        case solid
        case striped
        case open
        
        var opacity: Double {
            switch self {
            case .open:
                return 0
            case .striped:
                return 0.33
            case .solid:
                return 1
            }
        }
    }
    
    enum Color: SetCardGameFeature.Color {
        case red
        case green
        case purple
        
        var swiftUIColor: SwiftUI.Color {
            let colors: [Color: SwiftUI.Color] = [.red: .red, .green: .green, .purple: .purple]
            return colors[self]!
        }
    }
}
