//
//  ClassicSetCardGame.swift
//  SetCardGame
//
//  Created by Rachel Lee on 7/13/24.
//

import Foundation

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
    
    var allCards: Array<Card> {
        game.allCards
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
    
    func draw() {
        game.draw()
    }
}
