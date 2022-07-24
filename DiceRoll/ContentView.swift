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
            // DiceStackView()
            DiceGridView()
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


struct totalScore: View {
    @EnvironmentObject var game: DiceGame
    
    func goodLuckCharm() -> String {
        switch game.feelingLucky {
        case .lucky:
            return "🧧"
        case .unlucky:
            return "😿"
        default:
            return "🫤"

        }
    }
    
    var body: some View {
        HStack {
            Text("\(goodLuckCharm()) \(game.totalValue)")
                .font(.largeTitle)
        }
    }
}

struct GradientBackground: View {
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        if (colorScheme == .dark) {
            // dark mode: https://uigradients.com/#SandtoBlue
            LinearGradient(gradient: Gradient(stops: [
                    Gradient.Stop(color: Color(hex: 0x3E5151), location: 0.0),
                    Gradient.Stop(color: Color(hex: 0xDECBA4), location: 1.0)
            ]), startPoint: .top, endPoint: .bottom)
        } else {
            // light mode: https://uigradients.com/#Margo
            LinearGradient(gradient: Gradient(stops: [
                    Gradient.Stop(color: Color(hex: 0xFFEFBA), location: 0.0),
                    Gradient.Stop(color: Color(hex: 0xFFFFFF), location: 1.0)
            ]), startPoint: .top, endPoint: .bottom)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
//
