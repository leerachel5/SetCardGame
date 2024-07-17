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
        Text("Score: \(setGame.score)")
        
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
                ForEach(setGame.faceUpCards) { card in
                    CardView(card: card, isSelected: setGame.cardIsSelected(card))
                        .onTapGesture {
                            setGame.select(card: card)
                        }
                }
            }
            .padding()
        }
        HStack {
            Button(action: {
                setGame.drawCards()
            }, label: {
                Text("Draw")
            })
            
            Button(action: {
                let _ = setGame.matchSet()
            }, label: {
                Text("Match")
            })
        }
    }
}

#Preview {
    SetCardGameView()
}
