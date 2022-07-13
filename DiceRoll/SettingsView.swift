//
//  SettingsView.swift
//  DiceRoll
//
//  Created by Richard Hu on 07/11/2022.
//  Copyright © 2022 Happy Pisces. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    private let dieColors: Array<Color> = [.blue, .green, .pink, .purple]

    @State private var dieCount = 2
    @State private var dieColor = Color.blue

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("How many dices do you need?")) {
                    Picker("Number of dice", selection: $dieCount) {
                        ForEach(1...6, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section(header: Text("Die color:")) {
                    Picker("Die color", selection: $dieColor) {
                        ForEach(0..<4) {
                            Text("\(dieColors[$0].description.capitalized)")
                        }
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
