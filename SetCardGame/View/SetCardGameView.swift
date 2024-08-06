//
//  SetCardGameView.swift
//  SetCardGame
//
//  Created by Rachel Lee on 7/13/24.
//

import SwiftUI

struct SetCardGameView: View {
    @ObservedObject var setGame = ClassicSetCardGame()
    
    var body: some View {
        score
        
        cards
            .padding()
        
        actionButtons
    }
    
    var score: some View {
        Text("Score: \(setGame.score)")
    }
    
    var cards: some View {
        AspectVGrid(setGame.dealtCards, aspectRatio: 2/3) { card in
            SetCardView(card)
                .onTapGesture {
                    setGame.select(card: card)
                }
                .padding(1)
        }
    }
    
    var actionButtons: some View {
        HStack {
            Button(action: {
                setGame.drawCards()
            }, label: {
                Text("Deal 3 More Cards")
            })
            .disabled(setGame.deck.isEmpty)
            
            Button(action: {
                setGame.reset()
            }, label: {
                Text("New Game")
            })
        }
    }
}

#Preview {
    SetCardGameView()
}
