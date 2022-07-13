//
//  UtilityExtensions.swift
//  DiceRoll
//
//  Created by Richard Hu on 07/12/2022.
//  Copyright © 2022 Happy Pisces. All rights reserved.
//

import SwiftUI

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}
