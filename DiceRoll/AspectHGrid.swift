//
//  AspectHGrid.swift
//  DiceRoll
//
//  Created by Richard Hu on 07/22/2022.
//  Copyright © 2022 Happy Pisces. All rights reserved.
//

import SwiftUI

struct AspectHGrid<Item, ItemView>: View where Item: Identifiable, ItemView: View {
    var items: [Item]
    var aspectRatio: CGFloat
    var content: (Item) -> ItemView
    
    init(items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                let height = heightThatFits(itemCount: items.count, in: geometry.size, itemAspecRatio: aspectRatio)
                Spacer()
                LazyHGrid(rows: [adaptiveGridItem(height: height)], spacing: 0) {
                    ForEach(Array(items.enumerated()), id: \.offset) { _, item in
                        content(item).aspectRatio(aspectRatio, contentMode: .fit)
                    }
                }
                Spacer()
            }
        }
    }
    
    private func adaptiveGridItem(height: CGFloat) -> GridItem {
        var gridItem = GridItem(.adaptive(minimum: height))
        gridItem.spacing = 0
        return gridItem
    }
    
    
    private func heightThatFits(itemCount: Int, in size: CGSize, itemAspecRatio: CGFloat) -> CGFloat {
        if itemCount == 1 {
            return size.width / 1.3
        }
        
        var rowCount = 1
        var columnCount = itemCount
        
        repeat {
            let itemHeight = size.height / CGFloat(rowCount)
            let itemWidth = itemHeight * itemAspecRatio
            
            if CGFloat(columnCount) * itemWidth < size.width {
                break
            }
            rowCount += 1
            columnCount = (itemCount + (rowCount - 1)) / rowCount
        } while rowCount < itemCount
        
        if rowCount > itemCount {
            rowCount = itemCount
        }
        
        return floor(size.height / CGFloat(rowCount))
    }
}

//struct AspectHGrid_Previews: PreviewProvider {
//    static var previews: some View {
//        AspectHGrid()
//    }
//}

