//
//  BerlinClock+Factory.swift
//  BerlinClock
//
//  Created by Hugo Alonso on 21/03/2021.
//

import Foundation

extension BerlinClock {
    public static func create(
        calendar: Calendar = .init(identifier: .gregorian),
        colorSchema: ColorSchema = .init(off: "0", seconds: "Y", minutes: "Y", minutesVisualAid: "R", hours: "R")
    ) -> BerlinClockTimeProvider {
        let clock = BerlinClock(berlinClock: .init(), calendar: calendar)
        let formatter = BerlinClockUI(berlinClock: clock, colorSchema: colorSchema)
        return formatter
    }
}
