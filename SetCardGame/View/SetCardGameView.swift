//
//  SetCardGameView.swift
//  SetCardGame
//
//  Created by Rachel Lee on 7/13/24.
//

import SwiftUI

struct SetCardGameView: View {
    @ObservedObject var viewModel = SetCardGameViewModel()
    
    var body: some View {
        CardView(card: Card (
                number: Card.Number.one,
                shape: Card.Shape.squiggle,
                shading: Card.Shading.solid,
                color: Card.Color.purple,
                id: "1"
            )
        )
    }
}

#Preview {
    SetCardGameView()
}
