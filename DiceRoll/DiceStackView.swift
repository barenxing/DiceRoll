//
//  DiceStackView.swift
//  DiceRoll
//
//  Created by Richard Hu on 07/12/2022.
//  Copyright © 2022 Happy Pisces. All rights reserved.
//

import SwiftUI

struct DiceStackView: View {
    private(set) var diceCount: Int
    @State private var diceFaces: Array<String>
    @State private var rotateFaces: Array<Bool>

    
    init(diceCount: Int) {
        self.diceCount = diceCount
        diceFaces = Array(repeating: "die.face.1", count: diceCount)
        rotateFaces = Array(repeating: false, count: diceCount)
    }
    
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                ShakableViewRepresentable()
                    .allowsHitTesting(false)
                VStack {
                    let size = min(geo.size.width, geo.size.height / Double(diceCount)) * 0.75
                    ForEach(Array(diceFaces.enumerated()), id: \.offset) { i, die in
                        Image(systemName: die)
                            .resizable()
                            .foregroundColor(.blue)
                            .frame(width: size, height: size, alignment: .center)
                            .rotationEffect(Angle.degrees(rotateFaces[i] ? 360*5: 0))
                            .animation(Animation.easeInOut, value: rotateFaces[i])
                            .padding()

                    }
                }
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
        for i in 0..<diceCount {
            rotateFaces[i].toggle()
            diceFaces[i] = "die.face.\(Int.random(in: 1...6))"
        }
    }
}

struct DiceStackView_Previews: PreviewProvider {
    static var previews: some View {
        DiceStackView(diceCount: 3)
    }
}
