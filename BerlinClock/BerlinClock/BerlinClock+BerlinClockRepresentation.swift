//
//  BerlinClock+BerlinClockRepresentation.swift
//  BerlinClock
//
//  Created by Hugo Alonso on 21/03/2021.
//

import Foundation

extension BerlinClock: BerlinClockRepresentation {
    func singleMinuteRow(for date: Date) -> String {
        singleMinuteRow(for: date)
            .map { $0 ? "Y" : "0" }
            .joined()
    }

    func fiveMinuteRow(for date: Date) -> String {
        fiveMinuteRow(for: date)
            .map { $0 ? "Y" : "0" }
            .joined()
            .replacingOccurrences(of: "YYY", with: "YYR")
    }

    func fiveHourRow(for date: Date) -> String {
        fiveHourRow(for: date)
            .map { $0 ? "R" : "0" }
            .joined()
    }

    func singleHourRow(for date: Date) -> String {
        singleHourRow(for: date)
            .map { $0 ? "R" : "0" }
            .joined()
    }

    func secondsLamp(for date: Date) -> String {
        secondsLamp(for: date) ? "Y" : "0"
    }

    func berlinClockTime(for date: Date) -> String {
        return [
            secondsLamp(for: date),
            fiveHourRow(for: date),
            singleHourRow(for: date),
            fiveMinuteRow(for: date),
            singleMinuteRow(for: date)
        ].joined()
    }
}
