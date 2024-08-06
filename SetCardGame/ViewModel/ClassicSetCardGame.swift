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
    
    @Published private var game: GameModel!
    @Published private(set) var score: Int!
    
    init() {
        initializeNewGame()
    }
    
    private func initializeNewGame() {
        game = SetCardGame(numberOfStartingCards: 12)
        score = 0
    }
    
    func reset() {
        initializeNewGame()
    }
    
    var deck: Array<Card> {
        game.getPartition(for: .deck)
    }
    
    var dealtCards: Array<Card> {
        game.getPartition(for: .dealt)
    }
    
    func select(card: Card) {
        game.select(card)
    }
    
    func drawCards() {
        game.draw()
    }
}

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
