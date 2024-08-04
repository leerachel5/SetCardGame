//
//  ClassicSetCardGame.swift
//  SetCardGame
//
//  Created by Rachel Lee on 7/13/24.
//

import Foundation

class ClassicSetCardGame: ObservableObject {
    typealias GameModel = SetCardGame<Number, Shape, Shading, Color>
    typealias MatchingSet = GameModel.MatchingSet
    typealias Card = GameModel.Card
    
    @Published private var game: GameModel
    @Published private(set) var score: Int
    
    @Published private var selectedCards: GameModel.MatchingSet
    
    init() {
        game = SetCardGame(numberOfStartingCards: 12)
        score = 0
        
        selectedCards = MatchingSet()

    }
    
    var deck: Array<Card> {
        game.deck
    }
    
    var faceUpCards: Array<Card> {
        game.faceUpCards
    }
    
    func select(card: Card) {
        if selectedCards.contains(card) {
            // Deselect card
            if let selectedCard = selectedCards.firstIndex(of: card) {
                let _ = selectedCards.remove(at: selectedCard)
            }
        } else {
            // Select card
            if selectedCards.count < 3 {
                selectedCards.append(card)
            }
        }
    }
    
    func cardIsSelected(_ card: Card) -> Bool {
        return selectedCards.contains(card)
    }
    
    func drawCards() {
        game.drawFaceUpCards(count: 3)
    }
    
    func matchSet() -> Bool {
        let matched = game.matchSet(for: selectedCards) {
            self.score += 1
        }
        return matched
    }
}
