//
//  CardView.swift
//  SetCardGame
//
//  Created by Rachel Lee on 7/13/24.
//

import SwiftUI

struct CardView: View {
    let card: Card
    let isSelected: Bool
    
    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .strokeBorder(isSelected ? .yellow : .black)
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
                shape
                    .strokeBorder(.opacity(1))
                    .fill(.opacity(card.shading.opacity()))
                    .aspectRatio(2, contentMode: .fit)
                Spacer()
            }
        }
        .foregroundStyle(card.color.rawColor)
    }
    
    var shape: AnyInsettableShape {
        switch card.shape {
        case .squiggle:
            AnyInsettableShape(Squiggle())
        case .oval:
            AnyInsettableShape(Oval())
        case .diamond:
            AnyInsettableShape(Diamond())
        }
    }
}


#Preview {
    VStack {
        CardView(card: Card (
                number: Card.Number.one,
                shape: Card.Shape.diamond,
                shading: Card.Shading.solid,
                color: Card.Color.purple,
                id: "1"
            ), isSelected: false
        )
        CardView(card: Card (
                number: Card.Number.two,
                shape: Card.Shape.oval,
                shading: Card.Shading.striped,
                color: Card.Color.purple,
                id: "2"
            ), isSelected: true
        )
        CardView(card: Card (
                number: Card.Number.three,
                shape: Card.Shape.squiggle,
                shading: Card.Shading.open,
                color: Card.Color.purple,
                id: "3"
            ), isSelected: false
        )
    }
}
