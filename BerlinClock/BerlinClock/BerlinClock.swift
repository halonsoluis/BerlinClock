//
//  BerlinClock.swift
//  BerlinClock
//
//  Created by ***REMOVED*** on 21/03/2021.
//

import Foundation

public final class BerlinClock {

    public struct ColorSchema {
        public init(off: String, seconds: String, minutes: String, minutesVisualAid: String, hours: String) {
            self.off = off
            self.seconds = seconds
            self.minutes = minutes
            self.minutesVisualAid = minutesVisualAid
            self.hours = hours
        }

        let off: String
        let seconds: String
        let minutes: String
        let minutesVisualAid: String
        let hours: String
    }

    private let calendar: Calendar
    private let berlinClock: BerlinClockEngine
    let colorSchema: ColorSchema

    init(berlinClock: BerlinClockEngine = .init(),
         calendar: Calendar = .init(identifier: .gregorian),
         colorSchema: ColorSchema = .init(off: "0", seconds: "Y", minutes: "Y", minutesVisualAid: "R", hours: "R")) {
        self.calendar = calendar
        self.colorSchema = colorSchema
        self.berlinClock = berlinClock
    }

    func secondsLamp(for date: Date) -> Bool {
        berlinClock.secondsLamp(for: seconds(from: date))
    }

    func fiveHourRow(for date: Date) -> [Bool] {
        berlinClock.fiveHourRow(for: hours(from: date))
    }

    func singleHourRow(for date: Date) -> [Bool] {
        berlinClock.singleHourRow(for: hours(from: date))
    }

    func fiveMinuteRow(for date: Date) -> [Bool] {
        berlinClock.fiveMinuteRow(for: minutes(from: date))
    }

    func singleMinuteRow(for date: Date) -> [Bool] {
        berlinClock.singleMinuteRow(for: minutes(from: date))
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

extension BerlinClock {
    public static func create(
        calendar: Calendar = .init(identifier: .gregorian),
        colorSchema: BerlinClock.ColorSchema = .init(off: "0", seconds: "Y", minutes: "Y", minutesVisualAid: "R", hours: "R")
    ) -> BerlinClockTimeProvider {
        BerlinClock(berlinClock: .init(), calendar: calendar, colorSchema: colorSchema)
    }
}
