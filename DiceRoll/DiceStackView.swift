//
//  DiceStackView.swift
//  DiceRoll
//
//  Created by Richard Hu on 07/12/2022.
//  Copyright © 2022 Happy Pisces. All rights reserved.
//

import SwiftUI

struct DiceStackView: View {
    @EnvironmentObject var game: DiceGame
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                // make shakable the bottom layer, so it won't impact anything
                ShakableViewRepresentable()
                    .allowsHitTesting(false)
                    .onReceive(messagePublisher) { _ in game.rollDice() }

                // linear Gradient background
                GradientBackground()
                    .ignoresSafeArea()

                VStack {
                    totalScore()
                    let size = min(geo.size.width, (geo.size.height - 60) / Double(game.diceCount)) * 0.85
                    ForEach(Array(game.dice.enumerated()), id: \.offset) { _, die in
                        Image(systemName: die.face)
                            .resizable()
                            .foregroundColor(game.faceColor)
                            .frame(width: size, height: size, alignment: .center)
                            .rotationEffect(Angle.degrees(game.isRolling ? 360*5 : 0))
                            .animation(Animation.easeInOut, value: game.isRolling)
                            .padding(.bottom, CGFloat(5 * (game.diceCount>2 ? 1 : 4)))
                    } // ForEach
                } // VStack
                    .onTapGesture(count: 1) { game.rollDice() }
                    .gesture(DragGesture().onEnded({_ in game.rollDice()}))
            } // ZStack
        } // Geo Reader
    } // body
} // struct


struct DiceStackView_Previews: PreviewProvider {
    static var previews: some View {
        DiceStackView()
            .environmentObject(DiceGame())
    }
}
