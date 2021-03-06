//
//  DiceRollApp.swift
//  DiceRoll
//
//  Created by Richard Hu on 6/27/22.
//

import SwiftUI

@main
struct DiceRollApp: App {
    @StateObject var game = DiceGame()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(game)
        }
    }
}
