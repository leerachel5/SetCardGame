//
//  SetCardGameView.swift
//  SetCardGame
//
//  Created by Rachel Lee on 7/13/24.
//

import SwiftUI

struct SetCardGameView: View {
    @ObservedObject var setGame = SetCardGameViewModel()
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
                ForEach(setGame.faceUpCards) { card in
                    CardView(card: card)
                        .onTapGesture {
                            setGame.select(card: card)
                        }
                }
            }
            .padding()
        }
        Button(action: {
            let matched = setGame.matchSet()
            print("Matched: \(matched)")
        }, label: {
            Text("Match Set")
        })
    }
}

#Preview {
    SetCardGameView()
}
