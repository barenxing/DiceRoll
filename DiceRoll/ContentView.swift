//
//  ContentView.swift
//  DiceRoll
//
//  Created by Richard Hu on 6/27/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            DiceStackView()
                .tabItem {
                    Label("Dice", systemImage: "die.face.4")
                }
            SettingsView()
                .tabItem( {
                    Label("Settings", systemImage: "gear")
                })
        }
        
        
//        ZStack {
//            LinearGradient(gradient: Gradient(stops: [
//                    Gradient.Stop(color: Color(hex: 0xFFFFFF), location: 0.0),
//                    Gradient.Stop(color: Color(hex: 0xEF3B36), location: 1.0)]),
//                    startPoint: .top, endPoint: .bottom)
//            DiceStackView(diceCount: 3)
//        }
//        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
