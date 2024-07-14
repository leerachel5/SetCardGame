//
//  SetCardGameView.swift
//  SetCardGame
//
//  Created by Rachel Lee on 7/13/24.
//

import SwiftUI

struct SetCardGameView: View {
    var body: some View {
        CardView(
            numberOfShapes: CardFeature.Number.one,
            shape: CardFeature.Shape.diamond,
            shading: CardFeature.Shading.solid,
            color: CardFeature.Color.red
        )
    }
}

#Preview {
    SetCardGameView()
}
