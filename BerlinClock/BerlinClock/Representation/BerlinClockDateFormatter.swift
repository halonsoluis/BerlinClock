//
//  BerlinClockDateFormatter.swift
//  BerlinClock
//
//  Created by ---- ------ on 21/03/2021.
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
        let representation = berlinClock
            .singleMinuteRow(for: date)
            .map { $0 ? colorSchema.minutes : colorSchema.off }
        return String(representation)
    }

    func fiveMinuteRow(for date: Date) -> String {
        let representation = berlinClock
            .fiveMinuteRow(for: date)
            .map { $0 ? colorSchema.minutes : colorSchema.off }

        let resultWithoutVisualAid = String(representation)

        return resultWithoutVisualAid
            .replacingOccurrences(
                of: String([
                    colorSchema.minutes,
                    colorSchema.minutes,
                    colorSchema.minutes
                ]),
                with: String([
                    colorSchema.minutes,
                    colorSchema.minutes,
                    colorSchema.minutesVisualAid
                ])
            )
    }

    func fiveHourRow(for date: Date) -> String {
        let representation = berlinClock
            .fiveHourRow(for: date)
            .map { $0 ? colorSchema.hours : colorSchema.off }
        return String(representation)
    }

    func singleHourRow(for date: Date) -> String {
        let representation = berlinClock
            .singleHourRow(for: date)
            .map { $0 ? colorSchema.hours : colorSchema.off }
        return String(representation)
    }

    func secondsLamp(for date: Date) -> String {
        let representation = berlinClock
            .secondsLamp(for: date) ? colorSchema.seconds : colorSchema.off
        return String(representation)
    }
}
