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
    
    mutating private func removeCardsFromFaceUpPile<C: Sequence>(_ cards: C) where C.Element == Card {
        for card in faceUpCards {
            if cards.contains(card) {
                faceUpCards.remove(at: faceUpCards.firstIndex(of: card)!)
            }
        }
    }
    
    mutating func matchSet(for matchingSet: MatchingSet) throws -> Bool {
        
        guard matchingSet.count == 3 else {
            throw CardSelectionError.invalidNumberOfCardsInSet
        }
        
        let faceUpPileContainsSelectedCards = faceUpCards.containsAllElements(in: matchingSet)
        guard faceUpPileContainsSelectedCards else {
            throw CardSelectionError.selectedCardNotFaceUp
        }
        
        guard matchingSet.isMatchingSet else { return false }
        
        removeCardsFromFaceUpPile(matchingSet)
        
        let numberOfCardsToDraw = 12 - faceUpCards.count
        if numberOfCardsToDraw > 0 {
            drawFaceUpCards(count: numberOfCardsToDraw)
        }
        
        return true
    }
}

#if DEBUG
extension SetCardGame {
    mutating func setFaceUpCards<C: Sequence>(to cards: C) where C.Element == Card {
        faceUpCards = Array(cards)
    }
}
#endif
