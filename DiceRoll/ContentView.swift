//
//  ContentView.swift
//  DiceRoll
//
//  Created by Richard Hu on 6/27/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
                Text("\(Image(systemName: "die.face.1"))")
                Text("\(Image(systemName: "die.face.2"))")
                Text("\(Image(systemName: "die.face.3"))")
                Text("\(Image(systemName: "die.face.4"))")
                Text("\(Image(systemName: "die.face.5"))")
                Text("\(Image(systemName: "die.face.6"))")
        }
        .font(.system(size: 100))
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
