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
    static var baselineDealtCardCount: Int { 12 }
    
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
        return cards[.dealt]!.filter({ $0.selected })
    }
    
    private func getIndex(of card: Card) -> Int? {
        return cards[card.partition]!.firstIndex(where: { $0.id == card.id })
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
    mutating func draw(count: Int = Self.setCount) {
        guard cards[.deck]!.count >= count else { return }
        
        let selectedCards = getSelectedCards()
        if selectedCards.count == Self.setCount && selectedCards.first?.matched == true {
            for selectedCard in selectedCards {
                replaceCard(selectedCard, with: getRandomCard(from: .deck)!, moveTo: .discarded)
            }
        } else {
            for _ in 0..<count {
                moveRandomCard(from: .deck, to: .dealt)
            }
        }
    }
    
    mutating func select(_ card: Card) {
        guard card.partition == .dealt else { return }
        
        var selectedCards = getSelectedCards()
        if selectedCards.count == Self.setCount {
            for selectedCard in selectedCards {
                if selectedCard.matched == true {
                    if selectedCards.contains(card) { return }
                    if let newCard = getRandomCard(from: .deck) {
                        if cards[.dealt]!.count > Self.baselineDealtCardCount {
                            moveCard(selectedCard, to: .discarded)
                        } else {
                            replaceCard(selectedCard, with: newCard, moveTo: .discarded)
                        }
                    } else {
                        moveCard(selectedCard, to: .discarded)
                    }
                } else if selectedCard.matched == false {
                    if let selectedCardIndex = getIndex(of: selectedCard) {
                        cards[.dealt]![selectedCardIndex].matched = nil
                        cards[.dealt]![selectedCardIndex].selected = false
                    }
                }
            }
        }
        
        guard let chosenIndex = getIndex(of: card) else { return }
        cards[.dealt]![chosenIndex].selected.toggle()
        
        selectedCards = getSelectedCards()
        if selectedCards.count == Self.setCount {
            let matched = match(cards: selectedCards)
            for card in selectedCards {
                if let selectedCardIndex = getIndex(of: card) {
                    cards[.dealt]![selectedCardIndex].matched = matched
                }
            }
        }
    }
    
    private mutating func addCard(_ card: Card, to destination: Card.Partition) {
        cards[destination]?.append(card)
    }
    
    private mutating func addCard(_ card: Card, to destination: Card.Partition, at index: Int) {
        cards[destination]?.insert(card, at: index)
    }
    
    private mutating func removeCard(_ card: Card) -> Card? {
        return cards[card.partition]?.remove(card)
    }
    
    private mutating func replaceCard(_ originalCard: Card, with newCard: Card, moveTo destination: Card.Partition) {
        if let cardIndex = getIndex(of: originalCard) {
            moveCard(newCard, to: originalCard.partition, at: cardIndex)
            moveCard(originalCard, to: destination)
        }
    }
    
    private mutating func moveCard(_ card: Card, to destination: Card.Partition) {
        guard var cardToMove = removeCard(card) else { return }
        cardToMove.partition = destination
        addCard(cardToMove, to: destination)
    }
    
    private mutating func moveCard(_ card: Card, to destination: Card.Partition, at index: Int) {
        guard var cardToMove = removeCard(card) else { return }
        cardToMove.partition = destination
        addCard(cardToMove, to: destination, at: index)
    }
    
    private mutating func moveRandomCard(from origin: Card.Partition, to destination: Card.Partition) {
        if let randomCard = getRandomCard(from: origin) {
            moveCard(randomCard, to: destination)
        }
    }
}
