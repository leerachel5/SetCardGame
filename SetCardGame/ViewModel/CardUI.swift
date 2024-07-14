//
//  CardUI.swift
//  SetCardGame
//
//  Created by Rachel Lee on 7/14/24.
//

import SwiftUI

extension Card.Shading {
    func opacity() -> Double {
        switch self {
        case .open:
            0
        case .striped:
            0.33
        case .solid:
            1
        }
    }
}

extension Card.Color {
    var rawColor: SwiftUI.Color {
        let colors: [Card.Color: SwiftUI.Color] = [.red: .red, .green: .green, .purple: .purple]
        return colors[self]!
    }
}
