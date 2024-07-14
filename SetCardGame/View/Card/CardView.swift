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
    }
    
    @ViewBuilder
    var cardContent: some View {
        let opacity: Double = switch card.shading {
        case .open:
            0
        case .striped:
            0.33
        case .solid:
            1
        }
        
        VStack {
            Spacer()
            ForEach(Array(0..<card.number.rawValue), id: \.self) { _ in
                switch card.shape {
                case .squiggle:
                    Squiggle()
                        .strokeBorder(.opacity(1))
                        .fill(.opacity(opacity))
                        .aspectRatio(2, contentMode: .fit)
                case .oval:
                    Oval()
                        .strokeBorder(.opacity(1))
                        .fill(.opacity(opacity))
                        .aspectRatio(2, contentMode: .fit)
                case .diamond:
                    Diamond()
                        .strokeBorder(.opacity(1))
                        .fill(.opacity(opacity))
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
                shape: Card.Shape.diamond,
                shading: Card.Shading.solid,
                color: Card.Color.purple,
                id: "1"
            )
        )
        CardView(card: Card (
                number: Card.Number.two,
                shape: Card.Shape.oval,
                shading: Card.Shading.striped,
                color: Card.Color.purple,
                id: "2"
            )
        )
        CardView(card: Card (
                number: Card.Number.three,
                shape: Card.Shape.squiggle,
                shading: Card.Shading.open,
                color: Card.Color.purple,
                id: "3"
            )
        )
    }
}
