//
//  CardView.swift
//  SetCardGame
//
//  Created by Rachel Lee on 7/13/24.
//

import SwiftUI


import SwiftUI

struct CardView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .strokeBorder(lineWidth: 10)
            .foregroundStyle(.orange)
            .overlay {
                cardContent
            }
            .padding()
    }
    
    var cardContent: some View {
        Text("Card Content")
    }
}

#Preview {
    CardView()
}
