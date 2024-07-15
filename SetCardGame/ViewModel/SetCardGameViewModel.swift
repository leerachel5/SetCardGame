//
//  SetCardGameViewModel.swift
//  SetCardGame
//
//  Created by Rachel Lee on 7/13/24.
//

import Foundation

class SetCardGameViewModel: ObservableObject {
    @Published private var game: SetCardGame
    @Published private(set) var score: Int
    
    private var selectedCards: Array<Card> = []
    
    init() {
        game = SetCardGame(numberOfStartingCards: 12)
        score = 0
    }
    
    var deck: Array<Card> {
        game.deck
    }
    
    var faceUpCards: Array<Card> {
        game.faceUpCards
    }
    
    func select(card: Card) {
        if selectedCards.count < 3 {
            selectedCards.append(card)
        }
    }
    
    func matchSet() -> Bool {
        defer {
            selectedCards.removeAll()
        }
        
        do {
            let matched = try game.matchSet(for: selectedCards)
            if matched {
                score += 1
            }
            return matched
        } catch {
            print("Error matching with selected cards, \(error.localizedDescription)")
        }
        return false
    }
}
