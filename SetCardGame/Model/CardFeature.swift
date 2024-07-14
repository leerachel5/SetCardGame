//
//  CardFeature.swift
//  SetCardGame
//
//  Created by Rachel Lee on 7/13/24.
//

import SwiftUI

struct CardFeature {
    enum Number: Int {
        case one = 1
        case two = 2
        case three = 3
    }
    
    enum Shape {
        case diamond
        case squiggle
        case oval
        
        @ViewBuilder
        var view: some View {
            Group {
                switch self {
                case .diamond:
                    Diamond()
                case .squiggle:
                    Squiggle()
                case .oval:
                    // TODO: Replace RoundedRectangle with custom Oval Shape implementation
                    RoundedRectangle(cornerRadius: 72)
                }
            }
            .aspectRatio(2/1, contentMode: .fit)
        }
    }
    
    enum Shading {
        case solid
        case striped
        case open
    }
    
    enum Color: String {
        case red
        case green
        case purple
        
        var rawColor: SwiftUI.Color {
            let colors: [Color: SwiftUI.Color] = [.red: .red, .green: .green, .purple: .purple]
            return colors[self]!
        }
    }
}
