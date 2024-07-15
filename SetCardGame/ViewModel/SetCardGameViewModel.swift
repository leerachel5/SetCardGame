//
//  SetCardGameViewModel.swift
//  SetCardGame
//
//  Created by Rachel Lee on 7/13/24.
//

import Foundation

class SetCardGameViewModel: ObservableObject {
    @Published private var game: SetCardGame
    
    private var selectedCards: Array<Card> = []
    
    init() {
        game = SetCardGame(numberOfStartingCards: 12)
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
            print("Selected Cards: \(selectedCards)")
            return try game.matchSet(for: selectedCards)
        } catch {
            print("Error matching with selected cards, \(error.localizedDescription)")
        }
        return false
    }
}
