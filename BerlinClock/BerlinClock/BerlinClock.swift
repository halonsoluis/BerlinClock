//
//  BerlinClock.swift
//  BerlinClock
//
//  Created by ***REMOVED*** on 21/03/2021.
//

import Foundation

final class BerlinClock {

    let calendar: Calendar

    init(calendar: Calendar = .init(identifier: .gregorian)) {
        self.calendar = calendar
    }

    func fiveMinuteRow(for date: Date) -> [Bool] {
        calculateLights(
            total: 11,
            iluminated: extractMinute(from: date) / 5
        )
    }

    func singleMinuteRow(for date: Date) -> [Bool] {
        calculateLights(
            total: 4,
            iluminated: extractMinute(from: date) % 5
        )
    }

    func singleHourRow(for date: Date) -> [Bool] {
        calculateLights(
            total: 4,
            iluminated: extractHour(from: date) % 5
        )
    }


    func fiveHourRow(for date: Date) -> [Bool] {
        calculateLights(
            total: 4,
            iluminated: extractHour(from: date) / 5
        )
    }

    func secondsLamp(for date: Date) -> Bool {
        extractSecond(from: date) % 2 == 0
    }

    private func calculateLights(total amountOfLights: Int, iluminated: Int) -> [Bool] {
        let onLights = Array(repeating: true, count: iluminated)
        let offLights = Array(repeating: false, count: amountOfLights - iluminated)

        return onLights + offLights
    }
}

extension BerlinClock {
    func extractMinute(from date: Date) -> Int {
        calendar.component(.minute, from: date)
    }
    func extractHour(from date: Date) -> Int {
        calendar.component(.hour, from: date)
    }
    func extractSecond(from date: Date) -> Int {
        calendar.component(.second, from: date)
    }
}
