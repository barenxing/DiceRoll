//
//  ContentView.swift
//  DiceRoll
//
//  Created by Richard Hu on 6/27/22.
//

import SwiftUI


enum TabItemTag {
    case dice
    case setting
}

struct ContentView: View {
    @EnvironmentObject var game: DiceGame
    @State var tabSelection = TabItemTag.dice

    var body: some View {
        TabView (selection: $tabSelection) {
            DiceStackView()
                .tabItem {
                    Label("Dice", systemImage: "die.face.4")
                }
                .tag(TabItemTag.dice)
                .onAppear(perform: { game.rollDice() })
            SettingsView(tabSelection: $tabSelection)
                .tabItem{
                    Label("Settings", systemImage: "gear")
                }
                .tag(TabItemTag.setting)
        }
        .onChange(of: tabSelection) { _ in
            game.rollDice()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
