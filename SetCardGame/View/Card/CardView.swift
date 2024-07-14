//
//  CardView.swift
//  SetCardGame
//
//  Created by Rachel Lee on 7/13/24.
//

import SwiftUI

struct CardView: View {
    let card: Card
    
    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .strokeBorder()
            .foregroundStyle(.black)
            .overlay {
                cardContent
                    .padding()
            }
            .aspectRatio(2/3, contentMode: .fit)
            .padding()
    }
    
    @ViewBuilder
    var cardContent: some View {
        VStack {
            Spacer()
            ForEach(Array(0..<card.number.rawValue), id: \.self) { _ in
                switch card.shape {
                case .squiggle:
                    Squiggle()
                        .aspectRatio(2, contentMode: .fit)
                case .oval:
                    Oval()
                        .aspectRatio(2, contentMode: .fit)
                case .diamond:
                    Diamond()
                        .aspectRatio(2, contentMode: .fit)
                }
                Spacer()
            }
        }
        .foregroundStyle(card.color.rawColor)
    }
}


#Preview {
    VStack {
        CardView(card: Card (
                number: Card.Number.one,
                shape: Card.Shape.squiggle,
                shading: Card.Shading.solid,
                color: Card.Color.purple,
                id: "1"
            )
        )
        CardView(card: Card (
                number: Card.Number.two,
                shape: Card.Shape.oval,
                shading: Card.Shading.solid,
                color: Card.Color.purple,
                id: "2"
            )
        )
        CardView(card: Card (
                number: Card.Number.three,
                shape: Card.Shape.diamond,
                shading: Card.Shading.solid,
                color: Card.Color.purple,
                id: "3"
            )
        )
    }
}
