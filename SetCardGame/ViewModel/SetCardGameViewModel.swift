//
//  SetCardGameViewModel.swift
//  SetCardGame
//
//  Created by Rachel Lee on 7/13/24.
//

import Foundation

class SetCardGameViewModel: ObservableObject {
    @Published private var game: SetCardGame
    
    init() {
        game = SetCardGame(numberOfStartingCards: 12)
    }
    
    var deck: Array<Card> {
        game.deck
    }
    
    var faceUpCards: Array<Card> {
        game.faceUpCards
    }
}
