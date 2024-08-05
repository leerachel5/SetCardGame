//
//  SetCardGame.swift
//  SetCardGame
//
//  Created by Rachel Lee on 7/13/24.
//

import Foundation

struct SetCardGame<Number: SetCardGameFeature.Number, Shape: SetCardGameFeature.Shape, Shading: SetCardGameFeature.Shading, Color: SetCardGameFeature.Color> {
    // MARK: Typealiases
    typealias Deck = Dictionary<Card.Partition, Array<Card>>
    
    // MARK: Instance properties
    private var deck: Deck!
    
    // MARK: Initialization
    init() {
        deck = createDeck()
    }
    
    init(numberOfStartingCards: Int) {
        deck = createDeck()
        draw(count: numberOfStartingCards)
    }
    
    private func createDeck() -> Deck {
        var deck = createEmptyStatePartitionedDeck()
        
        var id = 0
        for number in Number.allCases {
            for shape in Shape.allCases {
                for shading in Shading.allCases {
                    for color in Color.allCases {
                        deck[.inDeck]!.append(Card(
                            number: number,
                            shape: shape,
                            shading: shading,
                            color: color,
                            state: .unselected,
                            partition: .inDeck,
                            id: String(id))
                        )
                        id += 1
                    }
                }
            }
        }
        return deck
    }
    
    private func createEmptyStatePartitionedDeck() -> Deck {
        var deck: Deck = [:]
        for partition in Card.Partition.allCases {
            deck[partition] = Array<Card>()
        }
        return deck
    }
    
    // MARK: Getter Methods and Computed Properties
    func getDeck() -> Array<Card> {
        var wholeDeck = Array<Card>()
        for partition in Card.Partition.allCases {
            wholeDeck.append(contentsOf: getPartition(for: partition))
        }
        return wholeDeck
    }
    
    func getPartition(for partition: Card.Partition) -> Array<Card> {
        return deck[partition]!
    }
    
    // MARK: Mutating Methods
    mutating func draw(count: Int) {
        for _ in 0..<count {
            moveRandomCard(from: .inDeck, to: .faceUp)
        }
    }
    
    mutating func select(_ card: Card) {
        guard card.partition == .faceUp else { return }
        
        guard let chosenIndex = deck[card.partition]!.firstIndex(where: { $0.id == card.id }) else { return }
        
        var selectedCards = deck[card.partition]!.filter({ $0.state == .selected })
        
        if selectedCards.count == 3 {
            for card in selectedCards {
                if card.state == .successfulMatch {
                    moveCard(card, to: .discarded)
                } else if card.state == .unsuccessfulMatch {
                    if let cardIndex = deck[card.partition]!.firstIndex(where: { $0.id == card.id }) {
                        deck[card.partition]![cardIndex].state = .unselected
                    }
                }
            }
        }
        
        deck[card.partition]![chosenIndex].state = .selected
        
        selectedCards = deck[card.partition]!.filter({ $0.state == .selected })
        
        if selectedCards.count == 3 {
            let matched = match(cards: selectedCards)
            for card in selectedCards {
                if let selectedCardIndex = deck[card.partition]!.firstIndex(where: { $0.id == card.id }) {
                    deck[card.partition]![selectedCardIndex].state = matched ? .successfulMatch : .unsuccessfulMatch
                }
            }
        }
    }
    
    private mutating func discard(_ card: Card) {
        moveCard(card, to: .discarded)
    }
    
    private mutating func moveCard(_ card: Card, to destination: Card.Partition) {
        guard var cardToMove = deck[card.partition]?.remove(card) else { return }
        cardToMove.partition = destination
        deck[destination]?.append(cardToMove)
    }
    
    private mutating func moveRandomCard(from origin: Card.Partition, to destination: Card.Partition) {
        guard let cardToMove = deck[origin]?.randomElement() else { return }
        moveCard(cardToMove, to: destination)
    }
    
    mutating private func match<CardCollection: Collection<Card>>(cards: CardCollection) -> Bool {
        guard cards.count == 3 else { return false }
        
        let numbers = cards.map({ $0.number })
        let shapes = cards.map({ $0.shape })
        let shadings = cards.map({ $0.shading })
        let colors = cards.map({ $0.color })
        
        let matched = (numbers.allTheSame() || numbers.allDifferent()) &&
                      (shapes.allTheSame() || shapes.allDifferent()) &&
                      (shadings.allTheSame() || shadings.allDifferent()) &&
                      (colors.allTheSame() || colors.allDifferent())
        
        return matched
    }
    
    mutating private func apply(to card: Card, _ function: (inout Card) -> Void) {
        if let index = deck[card.partition]!.firstIndex(of: card) {
            function(&(deck[card.partition]![index]))
        }
    }
}
