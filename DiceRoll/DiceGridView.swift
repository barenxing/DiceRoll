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
    @State private var isPortrait = false

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
                
                if (game.diceCount < 4) || (game.diceCount == 4 && isPortrait) {
                    AspectHGrid(items: game.dice, aspectRatio: 1) { die in
                        Image(systemName: die.face)
                            .resizable()
                            .foregroundColor(game.faceColor)
                            .rotationEffect(Angle.degrees(game.isRolling ? 360*5 : 0))
                            .animation(Animation.easeInOut, value: game.isRolling)
                            .padding(5)
                    } // AspectHGrid
                    .onTapGesture(count: 1) { game.rollDice() }
                    .gesture(DragGesture().onEnded({_ in game.rollDice()}))
                } else {
                    AspectVGrid(items: game.dice, aspectRatio: 1) { die in
                        Image(systemName: die.face)
                            .resizable()
                            .foregroundColor(game.faceColor)
                            .rotationEffect(Angle.degrees(game.isRolling ? 360*5 : 0))
                            .animation(Animation.easeInOut, value: game.isRolling)
                            .padding(5)
                    } // AspectVGrid
                    .onTapGesture(count: 1) { game.rollDice() }
                    .gesture(DragGesture().onEnded({_ in game.rollDice()}))
                }
            } // VStack
            
            // Show fireworks if value is the lucky value
            if (game.feelingLucky == .lucky) {
                ZStack {
                    Image(systemName: "heart.fill")
                        .symbolRenderingMode(.monochrome)
                        .foregroundColor(Color.pink)
                        .font(.system(size: 25, weight: .regular))
                        .modifier(ParticlesModifier())
                        .offset(x: -100, y : -50)
                    
                    Image(systemName: "star.fill")
                        .symbolRenderingMode(.monochrome)
                        .foregroundColor(.indigo)
                        .font(.system(size: 25, weight: .regular))
                        .modifier(ParticlesModifier())
                        .offset(x: 60, y : 70)
                }
            }
        } // ZStack
        .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
            guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
            self.isPortrait = scene.interfaceOrientation.isPortrait
        }
    } // body
}

struct DiceGridView_Previews: PreviewProvider {
    static var previews: some View {
        DiceGridView()
    }
}
