//
//  BerlinClock+BerlinClockTimeProvider.swift
//  BerlinClock
//
//  Created by ***REMOVED*** on 21/03/2021.
//

import Foundation

extension BerlinClock: BerlinClockTimeProvider {
    func time(for date: Date) -> String {
        return [
            secondsLamp(for: date),
            fiveHourRow(for: date),
            singleHourRow(for: date),
            fiveMinuteRow(for: date),
            singleMinuteRow(for: date)
        ].joined()
    }
}
