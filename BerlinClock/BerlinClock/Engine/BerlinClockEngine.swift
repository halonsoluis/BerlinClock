//
//  BerlinClockEngine.swift
//  BerlinClock
//
//  Created by ---- ------ on 21/03/2021.
//

import Foundation

final class BerlinClockEngine {
    func secondsLamp(for second: Int) -> Bool {
        second % 2 == 0
    }

    func fiveHourRow(for hour: Int) -> [Bool] {
        calculateLights(
            total: 4,
            iluminated: hour / 5
        )
    }

    func singleHourRow(for hour: Int) -> [Bool] {
        calculateLights(
            total: 4,
            iluminated: hour % 5
        )
    }

    func fiveMinuteRow(for minute: Int) -> [Bool] {
        calculateLights(
            total: 11,
            iluminated: minute / 5
        )
    }

    func singleMinuteRow(for minute: Int) -> [Bool] {
        calculateLights(
            total: 4,
            iluminated: minute % 5
        )
    }

    private func calculateLights(total amountOfLights: Int, iluminated: Int) -> [Bool] {
        let onLights = Array(repeating: true, count: iluminated)
        let offLights = Array(repeating: false, count: amountOfLights - iluminated)

        return onLights + offLights
    }
}
