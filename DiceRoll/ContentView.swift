//
//  ContentView.swift
//  DiceRoll
//
//  Created by Richard Hu on 6/27/22.
//

import SwiftUI

struct ContentView: View {
    @State var dice = Array(repeating: "die.face.1", count: 3)
    var body: some View {
        VStack {
            ForEach(dice, id: \.self) { die in
                Text("\(Image(systemName: die))")
            }
        }
        .font(.system(size: 200))
        .padding()
        .onTapGesture(count: 2) {
            for i in 0...dice.count-1 {
                dice[i] = "die.face.\(Int.random(in: 1...6))"
            }
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
