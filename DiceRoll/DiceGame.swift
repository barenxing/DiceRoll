//
//  DiceGame.swift
//  DiceRoll
//
//  Created by Richard Hu on 07/17/2022.
//  Copyright © 2022 Happy Pisces. All rights reserved.
//

import SwiftUI

class DiceGame: ObservableObject {
    // number of faces on each die, constant for now
    private let faces = 6
    let colorOptions: Array<Color> = [.pink, .blue, .black, .green, .indigo, .purple, .brown]

    @Published var diceCount: Int {
        didSet {
            diceValues = Array(repeating: 1, count: diceCount)
            rolling = Array(repeating: true, count: diceCount)
            rollDice()
        }
    }
    @Published var faceColor: Color
    @Published var diceValues: Array<Int>
    
    // for rolling to be an published value, need to keep it
    // as an array and not a calculated value
    @Published var rolling: Array<Bool>
    
    init(diceCount count: Int = 2, faceColor color: Color = .pink) {
        diceCount = count
        faceColor = color
        
        diceValues = Array(repeating: 1, count: count)
        rolling = Array(repeating: true, count: count)
        rollDice()
    }
    
    // MARK: - calculated var
    var diceFaces: Array<String> {
        diceValues.map { "die.face.\($0)"}
    }

    var totalValue: Int {
        diceValues.reduce(0, +)
    }
    
    // MARK: - Intents
    func setDiceCount(count: Int) {
        diceCount = count
    }
    
    func setFaceColor(color: Color) {
        faceColor = color
    }

    func rollDice() {
        for i in 0..<diceCount {
            rolling[i].toggle()
            diceValues[i] = Int.random(in: 1...faces)
        }
    }
}
