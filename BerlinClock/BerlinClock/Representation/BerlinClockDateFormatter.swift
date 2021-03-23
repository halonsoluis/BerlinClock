//
//  BerlinClockDateFormatter.swift
//  BerlinClock
//
//  Created by ***REMOVED*** on 21/03/2021.
//

import Foundation

final class BerlinClockDateFormatter: BerlinClockRepresentation {

    private let colorSchema: ColorSchema
    private let berlinClock: BerlinClock

    init(berlinClock: BerlinClock, colorSchema: ColorSchema) {
        self.berlinClock = berlinClock
        self.colorSchema = colorSchema
    }

    func singleMinuteRow(for date: Date) -> String {
        berlinClock.singleMinuteRow(for: date)
            .map { $0 ? colorSchema.minutes : colorSchema.off }
            .joined()
    }

    func fiveMinuteRow(for date: Date) -> String {
        berlinClock.fiveMinuteRow(for: date)
            .map { $0 ? colorSchema.minutes : colorSchema.off }
            .joined()
            .replacingOccurrences(
                of: [colorSchema.minutes, colorSchema.minutes, colorSchema.minutes].joined(),
                with: [ colorSchema.minutes, colorSchema.minutes, colorSchema.minutesVisualAid].joined()
            )
    }

    func fiveHourRow(for date: Date) -> String {
        berlinClock.fiveHourRow(for: date)
            .map { $0 ? colorSchema.hours : colorSchema.off }
            .joined()
    }

    func singleHourRow(for date: Date) -> String {
        berlinClock.singleHourRow(for: date)
            .map { $0 ? colorSchema.hours : colorSchema.off }
            .joined()
    }

    func secondsLamp(for date: Date) -> String {
        berlinClock.secondsLamp(for: date) ? colorSchema.seconds : colorSchema.off
    }
}
