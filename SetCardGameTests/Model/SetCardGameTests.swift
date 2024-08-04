//
//  SetCardGameTests.swift
//  SetCardGameTests
//
//  Created by Rachel Lee on 7/14/24.
//

@testable import SetCardGame
import XCTest

final class SetCardGameTests: XCTestCase {
    typealias Sut = SetCardGame<ClassicSetCardGame.Number, ClassicSetCardGame.Shape, ClassicSetCardGame.Shading, ClassicSetCardGame.Color>
    typealias Card = Sut.Card
    
    private var sut: Sut!
    
    override func setUp() {
        sut = .init()
    }
    
    func testInitializationGenerates81Cards() {
        XCTAssertEqual(sut.deck.count, 81)
    }
    
    func testInitializationGeneratesUniqueCardIds() {
        var seenIds = Dictionary<String, Bool>()
        
        for card in sut.deck {
            XCTAssertFalse(seenIds.keys.contains(card.id))
            seenIds[card.id] = true
        }
    }
    
    func testDrawnFaceUpCardsAreRemovedFromDeck() {
        let initialDeckCount = sut.deck.count
        let numberOfCardsToDraw = 12
        sut.drawFaceUpCards(count: numberOfCardsToDraw)
        
        XCTAssertEqual(sut.deck.count, initialDeckCount - numberOfCardsToDraw)
    }
    
    func testDrawnFaceUpCardsAreAppendedToFaceUpCards() {
        let numberOfCardsToDraw = 12
        sut.drawFaceUpCards(count: numberOfCardsToDraw)
        
        XCTAssertEqual(sut.faceUpCards.count, numberOfCardsToDraw)
    }
    
    func testMatchSetFor3AllSameFeaturesAnd1AllDifferentFeature() {
        let set = [
            Card(number: .one, shape: .oval, shading: .solid, color: .purple, id: "1"),
            Card(number: .one, shape: .oval, shading: .solid, color: .green, id: "2"),
            Card(number: .one, shape: .oval, shading: .solid, color: .red, id: "3"),
        ]
        
        sut.setFaceUpCards(to: set)
        
        XCTAssertTrue(sut.matchSet(for: Sut.MatchingSet(set)))
    }
    
    func testMatchSetFor2AllSameFeaturesAnd2AllDifferentFeatures() {
        let set = [
            Card(number: .one, shape: .oval, shading: .solid, color: .purple, id: "1"),
            Card(number: .one, shape: .oval, shading: .open, color: .green, id: "2"),
            Card(number: .one, shape: .oval, shading: .striped, color: .red, id: "3"),
        ]
        
        sut.setFaceUpCards(to: set)
        
        XCTAssertTrue(sut.matchSet(for: Sut.MatchingSet(set)))
    }
    
    func testMatchSetFor1AllSameFeatureAnd3AllDifferentFeatures() {
        let set = [
            Card(number: .one, shape: .oval, shading: .solid, color: .purple, id: "1"),
            Card(number: .one, shape: .diamond, shading: .open, color: .green, id: "2"),
            Card(number: .one, shape: .squiggle, shading: .striped, color: .red, id: "3"),
        ]
        
        sut.setFaceUpCards(to: set)
        
        XCTAssertTrue(sut.matchSet(for: Sut.MatchingSet(set)))
    }
    
    func testMatchSetFor4AllDifferentFeatures() {
        let set = [
            Card(number: .one, shape: .oval, shading: .solid, color: .purple, id: "1"),
            Card(number: .two, shape: .diamond, shading: .open, color: .green, id: "2"),
            Card(number: .three, shape: .squiggle, shading: .striped, color: .red, id: "3"),
        ]
        
        sut.setFaceUpCards(to: set)
        
        XCTAssertTrue(sut.matchSet(for: Sut.MatchingSet(set)))
    }
    
    func testMatchSetRemovesOnlyMatchedCardsFromFaceUpPile() {
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
        
        sut.setFaceUpCards(to: faceUpCards)
        
        let _ = sut.matchSet(for: Sut.MatchingSet(set))
        
        XCTAssertFalse(sut.faceUpCards.containsAllElements(in: set))
        XCTAssertTrue(sut.faceUpCards.containsAllElements(in: extraFaceUpCards))
    }
    
    func testMatchSetReturnsFalseForInvalidNumberCombination() {
        let set = [
            Card(number: .one, shape: .oval, shading: .solid, color: .purple, id: "1"),
            Card(number: .one, shape: .diamond, shading: .open, color: .green, id: "2"),
            Card(number: .three, shape: .squiggle, shading: .striped, color: .red, id: "3"),
        ]
        
        sut.setFaceUpCards(to: set)
        
        XCTAssertFalse(sut.matchSet(for: Sut.MatchingSet(set)))
    }
    
    func testMatchSetReturnsFalseForInvalidShapeCombination() {
        let set = [
            Card(number: .one, shape: .oval, shading: .solid, color: .purple, id: "1"),
            Card(number: .two, shape: .oval, shading: .open, color: .green, id: "2"),
            Card(number: .three, shape: .squiggle, shading: .striped, color: .red, id: "3"),
        ]
        
        sut.setFaceUpCards(to: set)
        
        XCTAssertFalse(sut.matchSet(for: Sut.MatchingSet(set)))
    }
    
    func testMatchSetReturnsFalseForInvalidShadingCombination() {
        let set = [
            Card(number: .one, shape: .oval, shading: .solid, color: .purple, id: "1"),
            Card(number: .two, shape: .diamond, shading: .solid, color: .green, id: "2"),
            Card(number: .three, shape: .squiggle, shading: .striped, color: .red, id: "3"),
        ]
        
        sut.setFaceUpCards(to: set)
        
        XCTAssertFalse(sut.matchSet(for: Sut.MatchingSet(set)))
    }
    
    func testMatchSetReturnsFalseForInvalidColorCombination() {
        let set = [
            Card(number: .one, shape: .oval, shading: .solid, color: .purple, id: "1"),
            Card(number: .two, shape: .diamond, shading: .open, color: .purple, id: "2"),
            Card(number: .three, shape: .squiggle, shading: .striped, color: .red, id: "3"),
        ]
        
        sut.setFaceUpCards(to: set)
        
        XCTAssertFalse(sut.matchSet(for: Sut.MatchingSet(set)))
    }
}
