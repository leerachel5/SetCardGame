//
//  SetCardGame.swift
//  SetCardGame
//
//  Created by Rachel Lee on 7/13/24.
//

import Foundation

struct SetCardGame<Number: SetCardGameFeature.Number, Shape: SetCardGameFeature.Shape, Shading: SetCardGameFeature.Shading, Color: SetCardGameFeature.Color> {
    // MARK: Typealiases
    typealias PartitionedCards = Dictionary<Card.Partition, Array<Card>>
    
    // MARK: Instance properties
    private var cards: PartitionedCards!
    
    // MARK: Initialization
    init() {
        cards = createCards()
    }
    
    init(numberOfStartingCards: Int) {
        cards = createCards()
        draw(count: numberOfStartingCards)
    }
    
    private func createCards() -> PartitionedCards {
        var deck = createEmptyStatePartitionedCards()
        
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
    
    private func createEmptyStatePartitionedCards() -> PartitionedCards {
        var deck: PartitionedCards = [:]
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
        return cards[partition]!
    }
    
    // MARK: Mutating Methods
    mutating func draw(count: Int) {
        for _ in 0..<count {
            moveRandomCard(from: .inDeck, to: .faceUp)
        }
    }
    
    mutating func select(_ card: Card) {
        guard card.partition == .faceUp else { return }
        
        var selectedCards = cards[card.partition]!.filter({ $0.selected })
        if selectedCards.count == 3 {
            for card in selectedCards {
                if card.matched == true {
                    moveCard(card, to: .discarded)
                } else if card.matched == false {
                    if let cardIndex = cards[card.partition]!.firstIndex(where: { $0.id == card.id }) {
                        cards[card.partition]![cardIndex].matched = nil
                        cards[card.partition]![cardIndex].selected = false
                    }
                }
            }
        }
        
        guard let chosenIndex = cards[card.partition]!.firstIndex(where: { $0.id == card.id }) else { return }
        cards[card.partition]![chosenIndex].selected.toggle()
        
        selectedCards = cards[card.partition]!.filter({ $0.selected })
        
        if selectedCards.count == 3 {
            let matched = match(cards: selectedCards)
            for card in selectedCards {
                if let selectedCardIndex = cards[card.partition]!.firstIndex(where: { $0.id == card.id }) {
                    cards[card.partition]![selectedCardIndex].matched = matched
                }
            }
        }
    }
    
    private mutating func discard(_ card: Card) {
        moveCard(card, to: .discarded)
    }
    
    private mutating func moveCard(_ card: Card, to destination: Card.Partition) {
        guard var cardToMove = cards[card.partition]?.remove(card) else { return }
        cardToMove.partition = destination
        cards[destination]?.append(cardToMove)
    }
    
    private mutating func moveRandomCard(from origin: Card.Partition, to destination: Card.Partition) {
        guard let cardToMove = cards[origin]?.randomElement() else { return }
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
}
