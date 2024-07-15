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
    
    func testMatchSetFor3AllSameFeaturesAnd1AllDifferentFeature() {
        var game = SetCardGame()
        
        let set = [
            Card(number: .one, shape: .oval, shading: .solid, color: .purple, id: "1"),
            Card(number: .one, shape: .oval, shading: .solid, color: .green, id: "2"),
            Card(number: .one, shape: .oval, shading: .solid, color: .red, id: "3"),
        ]
        
        game.setFaceUpCards(to: set)
        
        XCTAssertTrue((try? game.matchSet(for: set)) ?? false)
    }
    
    func testMatchSetFor2AllSameFeaturesAnd2AllDifferentFeatures() {
        var game = SetCardGame()
        
        let set = [
            Card(number: .one, shape: .oval, shading: .solid, color: .purple, id: "1"),
            Card(number: .one, shape: .oval, shading: .open, color: .green, id: "2"),
            Card(number: .one, shape: .oval, shading: .striped, color: .red, id: "3"),
        ]
        
        game.setFaceUpCards(to: set)
        
        XCTAssertTrue((try? game.matchSet(for: set)) ?? false)
    }
    
    func testMatchSetFor1AllSameFeatureAnd3AllDifferentFeatures() {
        var game = SetCardGame()
        
        let set = [
            Card(number: .one, shape: .oval, shading: .solid, color: .purple, id: "1"),
            Card(number: .one, shape: .diamond, shading: .open, color: .green, id: "2"),
            Card(number: .one, shape: .squiggle, shading: .striped, color: .red, id: "3"),
        ]
        
        game.setFaceUpCards(to: set)
        
        XCTAssertTrue((try? game.matchSet(for: set)) ?? false)
    }
    
    func testMatchSetFor4AllDifferentFeatures() {
        var game = SetCardGame()
        
        let set = [
            Card(number: .one, shape: .oval, shading: .solid, color: .purple, id: "1"),
            Card(number: .two, shape: .diamond, shading: .open, color: .green, id: "2"),
            Card(number: .three, shape: .squiggle, shading: .striped, color: .red, id: "3"),
        ]
        
        game.setFaceUpCards(to: set)
        
        XCTAssertTrue((try? game.matchSet(for: set)) ?? false)
    }
    
    func testMatchSetRemovesOnlyMatchedCardsFromFaceUpPile() {
        var game = SetCardGame()
        
        let set = [
            Card(number: .one, shape: .oval, shading: .solid, color: .purple, id: "1"),
            Card(number: .two, shape: .diamond, shading: .open, color: .green, id: "3"),
            Card(number: .three, shape: .squiggle, shading: .striped, color: .red, id: "4"),
        ]
        
        let extraFaceUpCards = [
            Card(number: .three, shape: .squiggle, shading: .striped, color: .green, id: "2"),
            Card(number: .one, shape: .squiggle, shading: .striped, color: .red, id: "5"),
        ]
        
        let faceUpCards = set + extraFaceUpCards
        
        game.setFaceUpCards(to: faceUpCards)
        
        let _ = try! game.matchSet(for: set)
        
        XCTAssertFalse(game.faceUpCards.contains(set))
        XCTAssertTrue(game.faceUpCards.contains(extraFaceUpCards))
    }
    
    func testMatchSetReturnsFalseForInvalidNumberCombination() {
        var game = SetCardGame()
        
        let set = [
            Card(number: .one, shape: .oval, shading: .solid, color: .purple, id: "1"),
            Card(number: .one, shape: .diamond, shading: .open, color: .green, id: "2"),
            Card(number: .three, shape: .squiggle, shading: .striped, color: .red, id: "3"),
        ]
        
        game.setFaceUpCards(to: set)
        
        XCTAssertFalse((try? game.matchSet(for: set)) ?? false)
    }
    
    func testMatchSetReturnsFalseForInvalidShapeCombination() {
        var game = SetCardGame()
        
        let set = [
            Card(number: .one, shape: .oval, shading: .solid, color: .purple, id: "1"),
            Card(number: .two, shape: .oval, shading: .open, color: .green, id: "2"),
            Card(number: .three, shape: .squiggle, shading: .striped, color: .red, id: "3"),
        ]
        
        game.setFaceUpCards(to: set)
        
        XCTAssertFalse((try? game.matchSet(for: set)) ?? false)
    }
    
    func testMatchSetReturnsFalseForInvalidShadingCombination() {
        var game = SetCardGame()
        
        let set = [
            Card(number: .one, shape: .oval, shading: .solid, color: .purple, id: "1"),
            Card(number: .two, shape: .diamond, shading: .solid, color: .green, id: "2"),
            Card(number: .three, shape: .squiggle, shading: .striped, color: .red, id: "3"),
        ]
        
        game.setFaceUpCards(to: set)
        
        XCTAssertFalse((try? game.matchSet(for: set)) ?? false)
    }
    
    func testMatchSetReturnsFalseForInvalidColorCombination() {
        var game = SetCardGame()
        
        let set = [
            Card(number: .one, shape: .oval, shading: .solid, color: .purple, id: "1"),
            Card(number: .two, shape: .diamond, shading: .open, color: .purple, id: "2"),
            Card(number: .three, shape: .squiggle, shading: .striped, color: .red, id: "3"),
        ]
        
        game.setFaceUpCards(to: set)
        
        XCTAssertFalse((try? game.matchSet(for: set)) ?? false)
    }
    
    func testMatchSetWithNonFaceUpCardsThrowsError() {
        var game = SetCardGame()
        
        let set = [
            Card(number: .one, shape: .oval, shading: .solid, color: .purple, id: "1"),
            Card(number: .two, shape: .diamond, shading: .open, color: .green, id: "2"),
            Card(number: .three, shape: .squiggle, shading: .striped, color: .red, id: "3"),
        ]
        
        XCTAssertThrowsError(try game.matchSet(for: set))
    }
}
