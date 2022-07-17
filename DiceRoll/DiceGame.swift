//
//  DiceGame.swift
//  DiceRoll
//
//  Created by Richard Hu on 07/17/2022.
//  Copyright © 2022 Happy Pisces. All rights reserved.
//

import SwiftUI

class DiceGame: ObservableObject {
    @Published var diceCount: Int {
        didSet {
            diceValues = Array(repeating: Int.random(in: 1...6), count: diceCount)
            rolling = Array(repeating: false, count: diceCount)
            rollDice()
        }
    }
    
    @Published var faceColor: Color = .blue
    @Published var diceValues: Array<Int>
    @Published var rolling: Array<Bool>
    private let faces = 6 // number of faces on each die, constant for now
    
    
    init(diceCount count: Int, faceColor color: Color) {
        diceCount = count
        faceColor = color
        
        diceValues = Array(repeating: Int.random(in: 1...6), count: count)
        rolling = Array(repeating: false, count: count)
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
