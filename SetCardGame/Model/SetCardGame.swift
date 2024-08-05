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
    
    // MARK: Static Properties
    static var setCount: Int { 3 }
    
    // MARK: Instance Properties
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
                        deck[.deck]!.append(Card(
                            number: number,
                            shape: shape,
                            shading: shading,
                            color: color,
                            partition: .deck,
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
    func getPartition(for partition: Card.Partition) -> Array<Card> {
        return cards[partition]!
    }
    
    private func getSelectedCards() -> Array<Card> {
        return cards[.faceUp]!.filter({ $0.selected })
    }
    
    private func getRandomCard(from partition: Card.Partition) -> Card? {
        return cards[partition]?.randomElement()
    }
    
    private func match<CardCollection: Collection<Card>>(cards: CardCollection) -> Bool {
        guard cards.count == Self.setCount else { return false }
        
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
    
    // MARK: Mutator Methods
    mutating func draw(count: Int) {
        for _ in 0..<count {
            moveRandomCard(from: .deck, to: .faceUp)
        }
    }
    
    mutating func select(_ card: Card) {
        guard card.partition == .faceUp else { return }
        
        var selectedCards = getSelectedCards()
        if selectedCards.count == Self.setCount {
            for selectedCard in selectedCards {
                if selectedCard.matched == true {
                    if selectedCards.contains(card) { return }
                    discard(selectedCard)
                } else if selectedCard.matched == false {
                    if let cardIndex = cards[.faceUp]!.firstIndex(where: { $0.id == selectedCard.id }) {
                        cards[.faceUp]![cardIndex].matched = nil
                        cards[.faceUp]![cardIndex].selected = false
                    }
                }
            }
        }
        
        guard let chosenIndex = cards[.faceUp]!.firstIndex(where: { $0.id == card.id }) else { return }
        cards[.faceUp]![chosenIndex].selected.toggle()
        
        selectedCards = getSelectedCards()
        
        if selectedCards.count == Self.setCount {
            let matched = match(cards: selectedCards)
            for card in selectedCards {
                if let selectedCardIndex = cards[.faceUp]!.firstIndex(where: { $0.id == card.id }) {
                    cards[.faceUp]![selectedCardIndex].matched = matched
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
        if let randomCard = getRandomCard(from: origin) {
            moveCard(randomCard, to: destination)
        }
    }
}
