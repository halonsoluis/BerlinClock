//
//  BerlinClock+BerlinClockRepresentation.swift
//  BerlinClock
//
//  Created by ***REMOVED*** on 21/03/2021.
//

import Foundation

extension BerlinClock: BerlinClockRepresentation {
    func singleMinuteRow(for date: Date) -> String {
        singleMinuteRow(for: date)
            .map { $0 ? colorSchema.minutes : colorSchema.off }
            .joined()
    }

    func fiveMinuteRow(for date: Date) -> String {
        fiveMinuteRow(for: date)
            .map { $0 ? colorSchema.minutes : colorSchema.off }
            .joined()
            .replacingOccurrences(
                of: [colorSchema.minutes, colorSchema.minutes, colorSchema.minutes].joined(),
                with: [ colorSchema.minutes, colorSchema.minutes, colorSchema.minutesVisualAid].joined()
            )
    }

    func fiveHourRow(for date: Date) -> String {
        fiveHourRow(for: date)
            .map { $0 ? colorSchema.hours : colorSchema.off }
            .joined()
    }

    func singleHourRow(for date: Date) -> String {
        singleHourRow(for: date)
            .map { $0 ? colorSchema.hours : colorSchema.off }
            .joined()
    }

    func secondsLamp(for date: Date) -> String {
        secondsLamp(for: date) ? colorSchema.seconds : colorSchema.off
    }
}
