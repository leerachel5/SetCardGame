//
//  SetCardGame.swift
//  SetCardGame
//
//  Created by Rachel Lee on 7/13/24.
//

import Foundation

struct SetCardGame {
    private(set) var deck: Array<Card>!
    private(set) var faceUpCards: Array<Card> = []
    
    init() {
        deck = SetCardGame.createDeck()
    }
    
    init(numberOfStartingCards: Int) {
        deck = SetCardGame.createDeck()
        drawFaceUpCards(count: numberOfStartingCards)
    }
    
    private static func createDeck() -> Array<Card> {
        var cards: Array<Card> = []
        var id = 0
        for number in Card.Number.allCases {
            for shape in Card.Shape.allCases {
                for shading in Card.Shading.allCases {
                    for color in Card.Color.allCases {
                        cards.append(Card(
                            number: number,
                            shape: shape,
                            shading: shading,
                            color: color,
                            id: String(id))
                        )
                        id += 1
                    }
                }
            }
        }
        return cards
    }
    
    mutating func drawFaceUpCards(count: Int) {
        for _ in 0..<min(deck.count, count) {
            // Pops a random card from the deck and appends it to the faceup cards
            if let randomCard = deck.indices.randomElement().map({ deck.remove(at: $0) }) {
                faceUpCards.append(randomCard)
            }
        }
    }
    
    mutating private func removeCardsFromFaceUpPile(_ set: Array<Card>) {
        for card in faceUpCards {
            if set.contains(card) {
                faceUpCards.remove(at: faceUpCards.firstIndex(of: card)!)
            }
        }
    }
    
    mutating func matchSet(for selectedCards: Array<Card>) throws -> Bool {
        // For each feature, the selected cards must display that feature as all the same or all different
        
        guard selectedCards.count == 3 else {
            throw CardSelectionError.invalidNumberOfCardsInSet
        }
        
        let cardsInFaceUp = faceUpCards.containsAllElements(in: selectedCards)
        guard cardsInFaceUp else {
            throw CardSelectionError.selectedCardNotFaceUp
        }
        
        let numbers = selectedCards.map { $0.number }
        let shape = selectedCards.map { $0.shape }
        let shading = selectedCards.map { $0.shading }
        let color = selectedCards.map { $0.color }
        
        guard numbers.allTheSame() || numbers.allDifferent() else { return false }
        guard shape.allTheSame() || shape.allDifferent() else { return false }
        guard shading.allTheSame() || shading.allDifferent() else { return false }
        guard color.allTheSame() || color.allDifferent() else { return false }
        
        removeCardsFromFaceUpPile(selectedCards)
        drawFaceUpCards(count: 3)
        
        return true
    }
}

#if DEBUG
extension SetCardGame {
    mutating func setFaceUpCards(to cards: Array<Card>) {
        faceUpCards = cards
    }
}
#endif
