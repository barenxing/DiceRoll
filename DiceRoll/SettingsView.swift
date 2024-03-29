//
//  SettingsView.swift
//  DiceRoll
//
//  Created by Richard Hu on 07/11/2022.
//  Copyright © 2022 Happy Pisces. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var game: DiceGame
    @Binding var tabSelection: TabItemTag
    private let diceNumberOptions = [1, 2, 3, 4, 5, 6]

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("How many dice?")) {
                    Picker("How many dice?", selection: $game.diceCount) {
                        ForEach(diceNumberOptions, id: \.self) {
                            Text("\($0)")
                        }
                    }
                        .pickerStyle(SegmentedPickerStyle())
                }
            
                Section() {
                    Picker("Die face color?", selection: $game.faceColor) {
                        ForEach(Die.colorOptions, id: \.self) {
                            ColorChoiceView(color: $0)
                        }
                    }
                    
                    Toggle("Change color for each roll", isOn: $game.dynamicColor)
                }
                
//                Section {
//                    Button("Apply") {
//                        tabSelection = TabItemTag.dice
//                        game.rollDice()
//                    }
//                }
            } // Form
            .navigationTitle("Settings")
            .navigationBarItems(trailing:
                Button("Done") {
                    tabSelection = TabItemTag.dice
                    game.rollDice()
                }
            )
        } // NavigationView
        .navigationViewStyle(.stack)
    } // body
}


struct ColorChoiceView: View {
    var color: Color
    var body: some View {
        HStack {
            Text("  ")
                .background(color)
            Text("\(color.description.capitalized)")
        }
    }
}

//struct SettingsView_Previews: PreviewProvider {
//    @Binding var tab = TabItemTag.setting
//
//    static var previews: some View {
//        SettingsView(tabSelection: $tab)
//            .environmentObject(DiceGame())
//    }
//}
