//
//  ClassicSetCardGame.swift
//  SetCardGame
//
//  Created by Rachel Lee on 7/13/24.
//

import SwiftUI

class ClassicSetCardGame: ObservableObject {
    typealias GameModel = SetCardGame<Number, Shape, Shading, Color>
    typealias Card = GameModel.Card
    
    @Published private var game: GameModel
    @Published private(set) var score: Int
    
    init() {
        game = SetCardGame(numberOfStartingCards: 12)
        score = 0
    }
    
    var deck: Array<Card> {
        game.getDeck()
    }
    
    var faceUpCards: Array<Card> {
        game.getPartition(for: .faceUp)
    }
    
    func select(card: Card) {
        game.select(card)
    }
    
    func drawCards() {
        game.draw(count: 3)
    }
}

extension SetCardGame.Card {
    var borderColor: SwiftUI.Color {
        switch state {
        case .unselected:
            return .black
        case .selected:
            return .yellow
        case .successfulMatch:
            return .green
        case .unsuccessfulMatch:
            return .red
        }
    }
}
