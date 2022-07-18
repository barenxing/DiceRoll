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

                VStack {
                    Text("Total: \(game.totalValue)")
                        .font(.title2)
                    let size = min(geo.size.width, (geo.size.height - 60) / Double(game.diceCount)) * 0.85
                    ForEach(Array(game.diceFaces.enumerated()), id: \.offset) { i, die in
                        Image(systemName: die)
                            .resizable()
                            .foregroundColor(game.faceColor)
                            .frame(width: size, height: size, alignment: .center)
                            .rotationEffect(Angle.degrees(game.rolling[i] ? 360*5: 0))
                            .animation(Animation.easeInOut, value: game.rolling[i])
                            .padding(.bottom, CGFloat(5 * (game.diceCount>2 ? 1 : 4)))
                    } // ForEach
                } // VStack
                    .onTapGesture(count: 1) { game.rollDice() }
                    .gesture(DragGesture().onEnded({_ in game.rollDice()}))

            } // ZStack
            .ignoresSafeArea()
        } // Geo Reader
    } // body
} // struct


struct GradientBackground: View {
    // will support more than two colors later.
    @State private var startColor: Color
    @State private var endColor: Color

    init(startColor: Color = Color(hex: 0xFFEFBA), endColor: Color = Color(hex: 0xFFFFFF)) {
        self.startColor = startColor
        self.endColor = endColor
    }
    
    var body: some View {
        LinearGradient(gradient: Gradient(stops: [
                Gradient.Stop(color: startColor, location: 0.0),
                Gradient.Stop(color: endColor, location: 1.0)
        ]), startPoint: .top, endPoint: .bottom)
    }
}


struct DiceStackView_Previews: PreviewProvider {
    static var previews: some View {
        DiceStackView()
            .environmentObject(DiceGame())
    }
}
