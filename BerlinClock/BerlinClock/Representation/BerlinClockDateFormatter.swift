//
//  BerlinClockDateFormatter.swift
//  BerlinClock
//
//  Created by Hugo Alonso on 21/03/2021.
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
        return berlinClock
            .singleMinuteRow(for: date)
            .map(colorForMinute)
            .asString()
    }

    func fiveMinuteRow(for date: Date) -> String {
        let minutes = berlinClock
            .fiveMinuteRow(for: date)
            .map(colorForMinute)
            .asString()

        return addVisualAid(to: minutes)
    }

    func fiveHourRow(for date: Date) -> String {
        return berlinClock
            .fiveHourRow(for: date)
            .map(colorForHour)
            .asString()
    }

    func singleHourRow(for date: Date) -> String {
        return berlinClock
            .singleHourRow(for: date)
            .map(colorForHour)
            .asString()
    }

    func secondsLamp(for date: Date) -> String {
        let isOn = berlinClock.secondsLamp(for: date)

        return colorForSeconds(status: isOn)
            .asString()
    }

    // MARK: - Helpers

    private func colorForMinute(status isOn: Bool) -> Character {
        colorize(as: colorSchema.minutes, if: isOn)
    }

    private func colorForHour(status isOn: Bool) -> Character {
        colorize(as: colorSchema.hours, if: isOn)
    }

    private func colorForSeconds(status isOn: Bool) -> Character {
        colorize(as: colorSchema.seconds, if: isOn)
    }

    private func colorize(as color: Character, if isOn: Bool) -> Character {
        isOn ? color : colorSchema.off
    }

    private func addVisualAid(to minutes: String) -> String {
        let original = String([
            colorSchema.minutes,
            colorSchema.minutes,
            colorSchema.minutes
        ])

        let replacer = String([
            colorSchema.minutes,
            colorSchema.minutes,
            colorSchema.minutesVisualAid
        ])

        return minutes.replacingOccurrences(of: original, with: replacer)
    }
}

extension Array where Element == Character {
    func asString() -> String {
        String(self)
    }
}

extension Character {
    func asString() -> String {
        String(self)
    }
}

