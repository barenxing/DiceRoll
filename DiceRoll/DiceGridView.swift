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
        ZStack {
            // make shakable the bottom layer, so it won't impact anything
            ShakableViewRepresentable()
                .allowsHitTesting(false)
                .onReceive(messagePublisher) { _ in game.rollDice() }

            // linear Gradient background
            GradientBackground()
                .ignoresSafeArea()

            VStack {
                Spacer(minLength: 20)
                totalScore()
                AspectHGrid(items: game.dice, aspectRatio: 1) { die in
                    Image(systemName: die.face)
                        .resizable()
                        .foregroundColor(game.faceColor)
                        .rotationEffect(Angle.degrees(game.isRolling ? 360*5 : 0))
                        .animation(Animation.easeInOut, value: game.faceColor)
                        .padding(5)
                } // AspectHGrid
                .onTapGesture(count: 1) { game.rollDice() }
                .gesture(DragGesture().onEnded({_ in game.rollDice()}))
            } // VStack
        } // ZStack
    } // body
}

struct DiceGridView_Previews: PreviewProvider {
    static var previews: some View {
        DiceGridView()
    }
}
