//
//  BerlinClock+Factory.swift
//  BerlinClock
//
//  Created by ***REMOVED*** on 21/03/2021.
//

import Foundation

extension BerlinClock {
    public static func create(
        calendar: Calendar = .init(identifier: .gregorian),
        colorSchema: BerlinClock.ColorSchema = .init(off: "0", seconds: "Y", minutes: "Y", minutesVisualAid: "R", hours: "R")
    ) -> BerlinClockTimeProvider {
        BerlinClock(berlinClock: .init(), calendar: calendar, colorSchema: colorSchema)
    }
}
