//
//  ColorSchema.swift
//  BerlinClock
//
//  Created by Hugo Alonso on 21/03/2021.
//

import Foundation

public struct ColorSchema {
    let off: Character
    let seconds: Character
    let minutes: Character
    let minutesVisualAid: Character
    let hours: Character

    public init(off: Character,
                seconds: Character,
                minutes: Character,
                minutesVisualAid: Character,
                hours: Character) {
        self.off = off
        self.seconds = seconds
        self.minutes = minutes
        self.minutesVisualAid = minutesVisualAid
        self.hours = hours
    }
}
