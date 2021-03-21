//
//  ColorSchema.swift
//  BerlinClock
//
//  Created by Hugo Alonso on 21/03/2021.
//

import Foundation

public struct ColorSchema {
    let off: String
    let seconds: String
    let minutes: String
    let minutesVisualAid: String
    let hours: String

    public init(off: String, seconds: String, minutes: String, minutesVisualAid: String, hours: String) {
        self.off = off
        self.seconds = seconds
        self.minutes = minutes
        self.minutesVisualAid = minutesVisualAid
        self.hours = hours
    }
}
