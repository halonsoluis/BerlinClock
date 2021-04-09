//
//  BerlinClock.swift
//  BerlinClock
//
//  Created by Hugo Alonso on 21/03/2021.
//

import Foundation

final class BerlinClock {
    private let calendar: Calendar

    init(calendar: Calendar) {
        self.calendar = calendar
    }

    func secondsLamp(for date: Date) -> Bool {
        seconds(from: date) % 2 == 0
    }

    func fiveHourRow(for date: Date) -> [Bool] {
        calculateLights(
            total: 4,
            iluminated: hours(from: date) / 5
        )
    }

    func singleHourRow(for date: Date) -> [Bool] {
        calculateLights(
            total: 4,
            iluminated: hours(from: date) % 5
        )
    }

    func fiveMinuteRow(for date: Date) -> [Bool] {
        calculateLights(
            total: 11,
            iluminated: minutes(from: date) / 5
        )
    }

    func singleMinuteRow(for date: Date) -> [Bool] {
        calculateLights(
            total: 4,
            iluminated: minutes(from: date) % 5
        )
    }

    private func calculateLights(total amountOfLights: Int, iluminated: Int) -> [Bool] {
        let onLights = Array(repeating: true, count: iluminated)
        let offLights = Array(repeating: false, count: amountOfLights - iluminated)

        return onLights + offLights
    }
}

// MARK: - Input Date Handling

extension BerlinClock {
    private func seconds(from date: Date) -> Int {
        calendar.component(.second, from: date)
    }
    private func minutes(from date: Date) -> Int {
        calendar.component(.minute, from: date)
    }
    private func hours(from date: Date) -> Int {
        calendar.component(.hour, from: date)
    }
}
