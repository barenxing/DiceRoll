//
//  ContentView.swift
//  DiceRoll
//
//  Created by Richard Hu on 6/27/22.
//

import SwiftUI

struct ContentView: View {
    private static let diceCount = 3
    @State private var dice = Array(repeating: "die.face.1", count: diceCount)
    @State private var rotates = Array(repeating: false, count: diceCount)

    var body: some View {
        GeometryReader { geo in
            ZStack {
                ShakableViewRepresentable()
                    .allowsHitTesting(false)
                LinearGradient(gradient: Gradient(stops: [
                        Gradient.Stop(color: Color(hex: 0xFFFFFF), location: 0.0),
                        Gradient.Stop(color: Color(hex: 0xEF3B36), location: 1.0)                ]), startPoint: .top, endPoint: .bottom)
                VStack {
                    let size = max(geo.size.width, geo.size.height) / Double(ContentView.diceCount) * 0.75
                    ForEach(Array(dice.enumerated()), id: \.offset) { i, die in
                        Image(systemName: die)
                            .resizable()
                            .foregroundColor(.blue)
                            .frame(width: size, height: size, alignment: .center)
                            .rotationEffect(Angle.degrees(rotates[i] ? 360*5: 0))
                            .animation(Animation.easeInOut, value: rotates[i])
                            .padding()

                    }
                }
                .ignoresSafeArea()
                .onTapGesture(count: 1) {
                    rollDice()
                }
                .gesture(DragGesture()
                    .onEnded({_ in
                        rollDice()
                    })
                )
                .onReceive(messagePublisher) { _ in
                    rollDice()
                }
            }
            .ignoresSafeArea()
        }
    }
    
    func rollDice() {
        for i in 0..<ContentView.diceCount {
            rotates[i].toggle()
            dice[i] = "die.face.\(Int.random(in: 1...6))"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
