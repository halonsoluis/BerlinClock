//
//  BerlinClockFactory.swift
//  BerlinClock
//
//  Created by Hugo Alonso on 21/03/2021.
//

import Foundation

public struct BerlinClockFactory {
    public static func create(
        calendar: Calendar = .init(identifier: .gregorian),
        colorSchema: ColorSchema = .init(off: "0", seconds: "Y", minutes: "Y", minutesVisualAid: "R", hours: "R")
    ) -> BerlinClockTimeProvider {
        let clock = BerlinClock(calendar: calendar)
        let formatter = BerlinClockDateFormatter(berlinClock: clock, colorSchema: colorSchema)
        return formatter
    }
}
