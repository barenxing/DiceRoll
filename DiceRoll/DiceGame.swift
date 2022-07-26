//
//  DiceGame.swift
//  DiceRoll
//
//  Created by Richard Hu on 07/17/2022.
//  Copyright © 2022 Happy Pisces. All rights reserved.
//

import SwiftUI

struct Die: Identifiable, Hashable {
    static let colorOptions: Array<Color> =
        [.pink, .blue, .mint, .black, .green, .indigo, .purple, .brown, .orange, .cyan, .gray]
    static let maxFaceValue = 6
    let id = UUID()
    
    // each die needs to have its own rotating state
    // in order to show animation of die rolling
    var isRotating = false
    var color: Color
    var value: Int

    init(value: Int, color: Color) {
        self.value = Int.random(in: 1...Die.maxFaceValue)
        self.color = Die.colorOptions.randomElement()!
    }
    
    init(color: Color) {
        self.value = Int.random(in: 1...Die.maxFaceValue)
        self.color = color
    }
    
    var face: String {
        "die.face.\(value)"
    }
}

class DiceGame: ObservableObject {
    @Published var diceCount: Int
    @Published var faceColor: Color
    @Published var dice: Array<Die>
    @Published var dynamicColor = true
    @Published var isRolling = false
    
    
    init(diceCount count: Int = 2, faceColor color: Color = .pink) {
        diceCount = count
        faceColor = color
        dice = [Die]()
        for _ in (0..<count) {
            dice.append(Die(color: color))
        }
    }
    
    // MARK: - calculated var
    var diceFaces: Array<String> {
        dice.map { "die.face.\($0.value)"}
    }

    var totalValue: Int {
        dice.reduce(0, { subtotal, y
            in subtotal + y.value
        })
    }
    
    var maxTotalValue: Int {
        Die.maxFaceValue * diceCount
    }

    var feelingLucky: Feeling {
        let oneThird = Double(diceCount * Die.maxFaceValue) / 3.0
        let twoThird = Double (diceCount * Die.maxFaceValue * 2) / 3.0
        if Double(totalValue) <= oneThird {
            return Feeling.unlucky
        } else if Double(totalValue) > oneThird && Double(totalValue) <= twoThird {
            return Feeling.meh
        } else {
            return Feeling.lucky
        }
    }
    
    // MARK: - Intents
    func setDiceCount(count: Int) {
        diceCount = count
    }
    
    func setFaceColor(color: Color) {
        faceColor = color
    }

    func rollDice() {
        if dynamicColor {
            faceColor = Die.colorOptions.randomElement()!
        }
        isRolling.toggle()

        // remove all dice and add
        dice.removeAll()
        for _ in (0..<diceCount) {
            dice.append(Die(color: faceColor))
        }
    }
    
    enum Feeling {
        case lucky
        case meh
        case unlucky
    }
}
