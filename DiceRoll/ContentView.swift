//
//  ContentView.swift
//  DiceRoll
//
//  Created by Richard Hu on 6/27/22.
//

import SwiftUI

struct ContentView: View {
    private static let diceCount = 2
    @State private var dice = Array(repeating: "die.face.1", count: diceCount)
    @State private var rotates = Array(repeating: false, count: diceCount)

    var body: some View {
        VStack {
            ForEach(Array(dice.enumerated()), id: \.offset) { i, die in
                Image(systemName: die)
                    .resizable()
                    .foregroundColor(.blue)
                    .frame(width: 200, height: 200, alignment: .center)
                    .rotationEffect(Angle.degrees(rotates[i] ? 360*5: 0))
                    .animation(Animation.easeInOut, value: rotates[i])
                    .padding()

            }
        }
        .onTapGesture(count: 2) {
            for i in 0..<ContentView.diceCount {
                rotates[i].toggle()
                dice[i] = "die.face.\(Int.random(in: 1...6))"
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
