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
                ShakableViewRepresentable()
                    .allowsHitTesting(false)
                    .onReceive(messagePublisher) { _ in game.rollDice() }

                VStack {
                    Text("Total: \(game.totalValue)")
                        .font(.title2)

                    let size = min(geo.size.width, geo.size.height / Double(game.diceCount)) * 0.75
                    ForEach(Array(game.diceFaces.enumerated()), id: \.offset) { i, die in
                        Image(systemName: die)
                            .resizable()
                            .foregroundColor(.blue)
                            .frame(width: size, height: size, alignment: .center)
                            .rotationEffect(Angle.degrees(game.rolling[i] ? 360*5: 0))
                            .animation(Animation.easeInOut, value: game.rolling[i])
                            .padding()
                    } // ForEach
                }
                    .onTapGesture(count: 1) { game.rollDice() }
                    .gesture(DragGesture().onEnded({_ in game.rollDice()}))

            } // ZStack
            .ignoresSafeArea()
        } // Geo Reader
    } // body
} // struct

struct DiceStackView_Previews: PreviewProvider {
    static var previews: some View {
        DiceStackView()
            .environmentObject(DiceGame(diceCount: 3, faceColor: .blue))
    }
}
