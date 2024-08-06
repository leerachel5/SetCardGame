//
//  ScrollAspectVGrid.swift
//  SetCardGame
//
//  Created by Rachel Lee on 8/5/24.
//

import SwiftUI

struct ScrollAspectVGrid<Item: Identifiable, ItemView: View>: View{
    var items: [Item]
    var aspectRatio: CGFloat = 1
    var minimumWidth: CGFloat? = nil
    var content: (Item) -> ItemView
    
    init(_ items: [Item], aspectRatio: CGFloat, minimumWidth: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.minimumWidth = minimumWidth
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geometry in
            let gridItemWidth = gridItemWidthThatFits(
                count: items.count,
                size: geometry.size,
                atAspectRatio: aspectRatio
            )
            
            if let minimumWidth = minimumWidth, gridItemWidth < minimumWidth {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: minimumWidth), spacing: 0)], spacing: 0) {
                        ForEach(items) { item in
                            content(item)
                                .aspectRatio(aspectRatio, contentMode: .fit)
                        }
                    }
                }
            } else {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemWidth), spacing: 0)], spacing: 0) {
                    ForEach(items) { item in
                        content(item)
                            .aspectRatio(aspectRatio, contentMode: .fit)
                    }
                }
            }
        }
    }
            
    private func gridItemWidthThatFits(
        count: Int,
        size: CGSize,
        atAspectRatio aspectRatio: CGFloat
    ) -> CGFloat {
        let count = CGFloat(count)
        var columnCount = 1.0
        repeat {
            let width = size.width / columnCount
            let height = width / aspectRatio
            
            let rowCount = (count / columnCount).rounded(.up)
            if rowCount * height < size.height {
                return (size.width / columnCount).rounded(.down)
            }
            columnCount += 1
        } while columnCount < count
        
        return min(size.width / count, size.height * aspectRatio).rounded(.down)
    }
}
