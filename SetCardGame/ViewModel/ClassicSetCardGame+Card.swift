//
//  ClassicSetCardGame+Card.swift
//  SetCardGame
//
//  Created by Rachel Lee on 8/5/24.
//

import SwiftUI

extension SetCardGame.Card {
    var borderColor: SwiftUI.Color {
        if !selected {
            return .black
        } else {
            if matched == true {
                return .green
            } else if matched == false {
                return .red
            } else {
                return .yellow
            }
        }
    }
}
