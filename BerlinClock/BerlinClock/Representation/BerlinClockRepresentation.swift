//
//  BerlinClockRepresentation.swift
//  BerlinClock
//
//  Created by Hugo Alonso on 21/03/2021.
//

import Foundation

protocol BerlinClockRepresentation {
    func singleMinuteRow(for date: Date) -> String
    func fiveMinuteRow(for date: Date) -> String
    func fiveHourRow(for date: Date) -> String
    func singleHourRow(for date: Date) -> String
    func secondsLamp(for date: Date) -> String
}
