//
//  BerlinClock.swift
//  BerlinClock
//
//  Created by Hugo Alonso on 21/03/2021.
//

import Foundation

final class BerlinClock {

    struct ColorSchema {
        let off: String
        let seconds: String
        let minutes: String
        let minutesVisualAid: String
        let hours: String
    }

    let calendar: Calendar
    let colorSchema: ColorSchema

    init(calendar: Calendar = .init(identifier: .gregorian),
         colorSchema: ColorSchema = .init(off: "0", seconds: "Y", minutes: "Y", minutesVisualAid: "R", hours: "R")) {
        self.calendar = calendar
        self.colorSchema = colorSchema
    }

    func secondsLamp(for date: Date) -> Bool {
        secondsLamp(for: seconds(from: date))
    }

    func fiveHourRow(for date: Date) -> [Bool] {
        fiveHourRow(for: hours(from: date))
    }

    func singleHourRow(for date: Date) -> [Bool] {
        singleHourRow(for: hours(from: date))
    }

    func fiveMinuteRow(for date: Date) -> [Bool] {
        fiveMinuteRow(for: minutes(from: date))
    }

    func singleMinuteRow(for date: Date) -> [Bool] {
        singleMinuteRow(for: minutes(from: date))
    }

    private func secondsLamp(for second: Int) -> Bool {
        second % 2 == 0
    }

    private func fiveHourRow(for hour: Int) -> [Bool] {
        calculateLights(
            total: 4,
            iluminated: hour / 5
        )
    }

    private func singleHourRow(for hour: Int) -> [Bool] {
        calculateLights(
            total: 4,
            iluminated: hour % 5
        )
    }

    private func fiveMinuteRow(for minute: Int) -> [Bool] {
        calculateLights(
            total: 11,
            iluminated: minute / 5
        )
    }

    private func singleMinuteRow(for minute: Int) -> [Bool] {
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
