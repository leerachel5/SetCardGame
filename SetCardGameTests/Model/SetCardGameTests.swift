//
//  SetCardGameTests.swift
//  SetCardGameTests
//
//  Created by Rachel Lee on 7/14/24.
//

@testable import SetCardGame
import XCTest

final class SetCardGameTests: XCTestCase {
    
    func testInitializationGenerates81Cards() {
        let game = SetCardGame()
        
        XCTAssertEqual(game.deck.count, 81)
    }
    
    func testInitializationGeneratesUniqueCardIds() {
        var seenIds = Dictionary<String, Bool>()
        
        let game = SetCardGame()
        
        for card in game.deck {
            XCTAssertFalse(seenIds.keys.contains(card.id))
            seenIds[card.id] = true
        }
    }
    
    func testInitializationGeneratesAllPossibleCardCombinations() {
        // TODO: IMPLEMENT
    }
    
    func testDrawnFaceUpCardsAreRemovedFromDeck() {
        var game = SetCardGame()
        
        let initialDeckCount = game.deck.count
        let numberOfCardsToDraw = 12
        game.drawFaceUpCards(count: numberOfCardsToDraw)
        
        XCTAssertEqual(game.deck.count, initialDeckCount - numberOfCardsToDraw)
    }
    
    func testDrawnFaceUpCardsAreAppendedToFaceUpCards() {
        var game = SetCardGame()
        
        let numberOfCardsToDraw = 12
        game.drawFaceUpCards(count: numberOfCardsToDraw)
        
        XCTAssertEqual(game.faceUpCards.count, numberOfCardsToDraw)
    }
    
    func testRemoveFaceUpCardForId() {
        var game = SetCardGame(numberOfStartingCards: 12)
        
        let cardIdToRemove = game.faceUpCards.first!.id
        let removedCard = game.removeFaceUpCard(forId: cardIdToRemove)
        
        XCTAssertFalse(game.faceUpCards.contains(removedCard!))
    }
    
}
