//
//  ContentView.swift
//  DiceRoll
//
//  Created by Richard Hu on 6/27/22.
//

import SwiftUI

struct ContentView: View {
    @State var dice = ["die.face.1", "die.face.6"]
    var body: some View {
        VStack {
                Text("\(Image(systemName: dice[0]))")
                Text("\(Image(systemName: dice[1]))")
        }
        .font(.system(size: 200))
        .padding()
        .onTapGesture(count: 2) {
            for i in 0...1 {
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
