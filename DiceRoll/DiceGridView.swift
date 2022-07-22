//
//  DiceGridView.swift
//  DiceRoll
//
//  Created by Richard Hu on 07/20/2022.
//  Copyright © 2022 Happy Pisces. All rights reserved.
//

import SwiftUI

struct DiceGridView: View {
    @EnvironmentObject var game: DiceGame
    
    var body: some View {
//        AspectVGrid(items: game.diceValues, aspectRatio: 1) { value in
//            Text(value)
//        }
        Text("Hello")
    }
}

struct DiceGridView_Previews: PreviewProvider {
    static var previews: some View {
        DiceGridView()
    }
}
