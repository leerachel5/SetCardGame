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
    
    mutating func matchSet(for matchingSet: MatchingSet, completion: () -> Void) -> Bool {
        do {
            try validateMatchingSet()
        } catch {
            print(error.localizedDescription)
            return false
        }
        
        guard matchingSet.isMatchingSet else { return false }
        
        replaceMatchingSetWithNewFaceUpCards()
        completion()
        
        return true
        
        func validateMatchingSet() throws {
            guard matchingSet.count == MatchingSet.completeSetCount else {
                throw CardSelectionError.invalidNumberOfCardsInSet
            }
            
            guard faceUpCards.containsAllElements(in: matchingSet) else {
                throw CardSelectionError.selectedCardNotFaceUp
            }
        }
        
        func replaceMatchingSetWithNewFaceUpCards() {
            removeCardsFromFaceUpPile(matchingSet)
            drawFaceUpCards(count: MatchingSet.completeSetCount)
        }
    }
}

#if DEBUG
extension SetCardGame {
    mutating func setFaceUpCards<C: Sequence>(to cards: C) where C.Element == Card {
        faceUpCards = Array(cards)
    }
}
#endif
