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
    private let colorOption: Array<Color> = [.blue, .green, .pink, .purple]
    private let countOption = [1, 2, 3, 4, 5, 6]

    var body: some View {
        Form {
            Section(header: Text("How many dice?")) {
                Picker("How many dice?", selection: $game.diceCount) {
                    ForEach(countOption, id: \.self) {
                        Text("\($0)")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            Section {
                Picker("Face color?", selection: $game.faceColor) {
                    ForEach(colorOption, id: \.self) {
                        Text("\($0.description.capitalized)")
                    }
                }
            }
        }
    } // body
    
    
}



struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(DiceGame(diceCount: 3, faceColor: .blue))
    }
}
