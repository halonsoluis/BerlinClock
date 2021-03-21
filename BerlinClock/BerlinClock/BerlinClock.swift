//
//  BerlinClock.swift
//  BerlinClock
//
//  Created by Hugo Alonso on 21/03/2021.
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
         calendar: Calendar,
         colorSchema: ColorSchema) {
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
