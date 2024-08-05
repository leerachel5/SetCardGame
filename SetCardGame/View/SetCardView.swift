//
//  SetCardView.swift
//  SetCardGame
//
//  Created by Rachel Lee on 7/13/24.
//

import SwiftUI

struct SetCardView<Number: SetCardGameFeature.Number, Shape: SetCardGameFeature.Shape, Shading: SetCardGameFeature.Shading, Color: SetCardGameFeature.Color>: View {
    
    typealias Card = SetCardGame<Number, Shape, Shading, Color>.Card
    
    private let card: Card
    
    init(_ card: Card) {
        self.card = card
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .strokeBorder(card.borderColor)
            .foregroundStyle(.black)
            .overlay {
                cardContent
                    .padding()
            }
            .aspectRatio(2/3, contentMode: .fit)
    }
    
    @ViewBuilder
    var cardContent: some View {
        VStack {
            Spacer()
            ForEach(Array(0..<card.number.rawValue), id: \.self) { _ in
                card.shape.insettableShape
                    .strokeBorder(.opacity(1))
                    .fill(.opacity(card.shading.opacity))
                    .aspectRatio(2, contentMode: .fit)
                Spacer()
            }
        }
        .foregroundStyle(card.color.swiftUIColor)
    }
}


#Preview {
    VStack {
        SetCardView(SetCardGame.Card(
                number: ClassicSetCardGame.Number.one,
                shape: ClassicSetCardGame.Shape.diamond,
                shading: ClassicSetCardGame.Shading.solid,
                color: ClassicSetCardGame.Color.purple,
                state: .unselected,
                partition: .faceUp,
                id: "1"
            )
        )
        SetCardView(SetCardGame.Card(
                number: ClassicSetCardGame.Number.two,
                shape: ClassicSetCardGame.Shape.oval,
                shading: ClassicSetCardGame.Shading.open,
                color: ClassicSetCardGame.Color.green,
                state: .selected,
                partition: .faceUp,
                id: "2"
            )
        )
        SetCardView(SetCardGame.Card(
                number: ClassicSetCardGame.Number.three,
                shape: ClassicSetCardGame.Shape.squiggle,
                shading: ClassicSetCardGame.Shading.striped,
                color: ClassicSetCardGame.Color.red,
                state: .successfulMatch,
                partition: .faceUp,
                id: "3"
            )
        )
    }
}
