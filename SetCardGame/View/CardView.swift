//
//  CardView.swift
//  SetCardGame
//
//  Created by Rachel Lee on 7/13/24.
//

import SwiftUI

struct CardView: View {
    let numberOfShapes: CardFeature.Number
    let shape: CardFeature.Shape
    let shading: CardFeature.Shading
    let color: CardFeature.Color
    
    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .strokeBorder()
            .foregroundStyle(.black)
            .overlay {
                shape.view
                    .foregroundColor(color.rawColor)
                    .aspectRatio(contentMode: .fit)
                    .padding()
            }
            .aspectRatio(3/5, contentMode: .fit)
            .padding()
    }
}

#Preview {
    VStack {
        CardView(
            numberOfShapes: CardFeature.Number.one,
            shape: CardFeature.Shape.squiggle,
            shading: CardFeature.Shading.solid,
            color: CardFeature.Color.purple
        )
        CardView(
            numberOfShapes: CardFeature.Number.one,
            shape: CardFeature.Shape.oval,
            shading: CardFeature.Shading.solid,
            color: CardFeature.Color.purple
        )
        CardView(
            numberOfShapes: CardFeature.Number.one,
            shape: CardFeature.Shape.diamond,
            shading: CardFeature.Shading.solid,
            color: CardFeature.Color.purple
        )
    }
}
