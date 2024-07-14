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
    
    func testMatchSetFor3AllSameFeaturesAnd1AllDifferentFeature() {
        let game = SetCardGame()
        
        let set = [
            Card(number: .one, shape: .oval, shading: .solid, color: .purple, id: "1"),
            Card(number: .one, shape: .oval, shading: .solid, color: .green, id: "2"),
            Card(number: .one, shape: .oval, shading: .solid, color: .red, id: "3"),
        ]
        
        XCTAssertTrue(game.matchSet(for: set))
    }
    
    func testMatchSetFor2AllSameFeaturesAnd2AllDifferentFeatures() {
        let game = SetCardGame()
        
        let set = [
            Card(number: .one, shape: .oval, shading: .solid, color: .purple, id: "1"),
            Card(number: .one, shape: .oval, shading: .open, color: .green, id: "2"),
            Card(number: .one, shape: .oval, shading: .striped, color: .red, id: "3"),
        ]
        
        XCTAssertTrue(game.matchSet(for: set))
    }
    
    func testMatchSetFor1AllSameFeatureAnd3AllDifferentFeatures() {
        let game = SetCardGame()
        
        let set = [
            Card(number: .one, shape: .oval, shading: .solid, color: .purple, id: "1"),
            Card(number: .one, shape: .diamond, shading: .open, color: .green, id: "2"),
            Card(number: .one, shape: .squiggle, shading: .striped, color: .red, id: "3"),
        ]
        
        XCTAssertTrue(game.matchSet(for: set))
    }
    
    func testMatchSetFor4AllDifferentFeatures() {
        let game = SetCardGame()
        
        let set = [
            Card(number: .one, shape: .oval, shading: .solid, color: .purple, id: "1"),
            Card(number: .two, shape: .diamond, shading: .open, color: .green, id: "2"),
            Card(number: .three, shape: .squiggle, shading: .striped, color: .red, id: "3"),
        ]
        
        XCTAssertTrue(game.matchSet(for: set))
    }
    
    func testMatchSetReturnsFalseForInvalidNumberCombination() {
        let game = SetCardGame()
        
        let set = [
            Card(number: .one, shape: .oval, shading: .solid, color: .purple, id: "1"),
            Card(number: .one, shape: .diamond, shading: .open, color: .green, id: "2"),
            Card(number: .three, shape: .squiggle, shading: .striped, color: .red, id: "3"),
        ]
        
        XCTAssertFalse(game.matchSet(for: set))
    }
    
    func testMatchSetReturnsFalseForInvalidShapeCombination() {
        let game = SetCardGame()
        
        let set = [
            Card(number: .one, shape: .oval, shading: .solid, color: .purple, id: "1"),
            Card(number: .two, shape: .oval, shading: .open, color: .green, id: "2"),
            Card(number: .three, shape: .squiggle, shading: .striped, color: .red, id: "3"),
        ]
        
        XCTAssertFalse(game.matchSet(for: set))
    }
    
    func testMatchSetReturnsFalseForInvalidShadingCombination() {
        let game = SetCardGame()
        
        let set = [
            Card(number: .one, shape: .oval, shading: .solid, color: .purple, id: "1"),
            Card(number: .two, shape: .diamond, shading: .solid, color: .green, id: "2"),
            Card(number: .three, shape: .squiggle, shading: .striped, color: .red, id: "3"),
        ]
        
        XCTAssertFalse(game.matchSet(for: set))
    }
    
    func testMatchSetReturnsFalseForInvalidColorCombination() {
        let game = SetCardGame()
        
        let set = [
            Card(number: .one, shape: .oval, shading: .solid, color: .purple, id: "1"),
            Card(number: .two, shape: .diamond, shading: .open, color: .purple, id: "2"),
            Card(number: .three, shape: .squiggle, shading: .striped, color: .red, id: "3"),
        ]
        
        XCTAssertFalse(game.matchSet(for: set))
    }
}
