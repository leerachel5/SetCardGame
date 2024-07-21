//
//  MatchingSet.swift
//  SetCardGame
//
//  Created by Rachel Lee on 7/21/24.
//

import Foundation

struct MatchingSet {
    private var numberOfCardsInSet = 3
    
    @CardLimit(maxCount: 3)
    private var cards: Array<Card> = []
    
    init() {}
    
    init?<C: Sequence>(_ cards: C, numberOfCardsInSet: Int) where C.Element == Card {
        self._cards = CardLimit(wrappedValue: Array(cards), maxCount: numberOfCardsInSet)
        
        self.numberOfCardsInSet = numberOfCardsInSet
    }
    
    var isMatchingSet: Bool {
        guard cards.count == self.numberOfCardsInSet else { return false }
        
        let numbers = cards.map { $0.number }
        let shape = cards.map { $0.shape }
        let shading = cards.map { $0.shading }
        let color = cards.map { $0.color }
        
        guard numbers.allTheSame() || numbers.allDifferent() else { return false }
        guard shape.allTheSame() || shape.allDifferent() else { return false }
        guard shading.allTheSame() || shading.allDifferent() else { return false }
        guard color.allTheSame() || color.allDifferent() else { return false }
        
        return true
    }
}

extension MatchingSet: RangeReplaceableCollection {
    typealias Element = Card
    typealias Index = Array<Card>.Index
    
    var startIndex: Index {
        return cards.startIndex
    }
    
    var endIndex: Index {
        return cards.endIndex
    }
    
    func index(after i: Index) -> Index {
        return cards.index(after: i)
    }
    
    subscript(position: Index) -> Card {
        return cards[position]
    }
    
    mutating func replaceSubrange<C>(_ subrange: Range<Index>, with newElements: C) where C : Collection, MatchingSet.Element == C.Element {
        cards.replaceSubrange(subrange, with: newElements)
    }
    
    mutating func append(_ newElement: Element) {
        cards.append(newElement)
    }
    
    mutating func append<S>(contentsOf newElements: S) where S : Sequence, MatchingSet.Element == S.Element {
        cards.append(contentsOf: newElements)
    }
    
    mutating func insert(_ newElement: Element, at i: Index) {
        cards.insert(newElement, at: i)
    }
    
    mutating func remove(at position: Index) -> Element {
        return cards.remove(at: position)
    }
    
    mutating func removeAll(keepingCapacity keepCapacity: Bool = false) {
        cards.removeAll(keepingCapacity: keepCapacity)
    }
}


@propertyWrapper
struct CardLimit {
    private var cards: [Card] = []
    private let maxCount: Int
    
    var wrappedValue: [Card] {
        get { cards }
        set {
            assert(newValue.count <= maxCount)
            cards = newValue
        }
    }
    
    init(wrappedValue: [Card], maxCount: Int) {
        self.maxCount = maxCount
        self.wrappedValue = wrappedValue
    }
}
