//
//  DiceRollApp.swift
//  DiceRoll
//
//  Created by Richard Hu on 6/27/22.
//

import SwiftUI

@main
struct DiceRollApp: App {
    @StateObject var game = DiceGame(diceCount: 1, faceColor: .blue)
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(game)
        }
    }
}
