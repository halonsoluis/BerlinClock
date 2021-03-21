//
//  BerlinClockTests.swift
//  BerlinClockTests
//
//  Created by Hugo Alonso on 21/03/2021.
//

import XCTest
@testable import BerlinClock

protocol BerlinClockRepresentation {
    func singleMinuteRow(for date: Date) -> String
    func fiveMinuteRow(for date: Date) -> String
    func fiveHourRow(for date: Date) -> String
    func singleHourRow(for date: Date) -> String
    func secondsLamp(for date: Date) -> String
}

final class BerlinClock {

    let calendar: Calendar

    init(calendar: Calendar = .init(identifier: .gregorian)) {
        self.calendar = calendar
    }

    private func fiveMinuteRow(for date: Date) -> [Bool] {
        calculateLights(
            total: 11,
            iluminated: extractMinute(from: date) / 5
        )
    }

    private func singleMinuteRow(for date: Date) -> [Bool] {
        calculateLights(
            total: 4,
            iluminated: extractMinute(from: date) % 5
        )
    }

    private func singleHourRow(for date: Date) -> [Bool] {
        calculateLights(
            total: 4,
            iluminated: extractHour(from: date) % 5
        )
    }


    private func fiveHourRow(for date: Date) -> [Bool] {
        calculateLights(
            total: 4,
            iluminated: extractHour(from: date) / 5
        )
    }

    private func secondsLamp(for date: Date) -> Bool {
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
}

final class BerlinClockTests: XCTestCase {

    // MARK: - Single Minutes Row
    
    func test_singleMinuteRow_returnsExpectedOutput() {
        assertSingleMinuteRow(minutes: [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55], returns: "0000")
        assertSingleMinuteRow(minutes: [1, 6, 11, 16, 21, 26, 31, 36, 41, 46, 51, 56], returns: "Y000")
        assertSingleMinuteRow(minutes: [2, 7, 12, 17, 22, 27, 32, 37, 42, 47, 52, 57], returns: "YY00")
        assertSingleMinuteRow(minutes: [3, 8, 13, 18, 23, 28, 33, 38, 43, 48, 53, 58], returns: "YYY0")
        assertSingleMinuteRow(minutes: [4, 9, 14, 19, 24, 29, 34, 39, 44, 49, 54, 59], returns: "YYYY")
    }

    // MARK: - Five Minutes Row

    func test_fiveMinuteRow_returnsExpectedOutput() {
        assertFiveMinuteRow(minutes: 0...4, returns: "00000000000")
        assertFiveMinuteRow(minutes: 5...9, returns: "Y0000000000")
        assertFiveMinuteRow(minutes: 10...14, returns: "YY000000000")
        assertFiveMinuteRow(minutes: 15...19, returns: "YYR00000000")
        assertFiveMinuteRow(minutes: 20...24, returns: "YYRY0000000")
        assertFiveMinuteRow(minutes: 25...29, returns: "YYRYY000000")
        assertFiveMinuteRow(minutes: 30...34, returns: "YYRYYR00000")
        assertFiveMinuteRow(minutes: 35...39, returns: "YYRYYRY0000")
        assertFiveMinuteRow(minutes: 40...44, returns: "YYRYYRYY000")
        assertFiveMinuteRow(minutes: 45...49, returns: "YYRYYRYYR00")
        assertFiveMinuteRow(minutes: 50...54, returns: "YYRYYRYYRY0")
        assertFiveMinuteRow(minutes: 55...59, returns: "YYRYYRYYRYY")
    }

    // MARK: - Five Hour Row

    func test_fiveHourRow_returnsExpectedOutput() {
        assertFiveHourRow(hours: 0...4, returns: "0000")
        assertFiveHourRow(hours: 5...9, returns: "R000")
        assertFiveHourRow(hours: 10...14, returns: "RR00")
        assertFiveHourRow(hours: 15...19, returns: "RRR0")
        assertFiveHourRow(hours: 20...23, returns: "RRRR")
    }

    // MARK: - Single Hour Row

    func test_singleHourRow_returnsExpectedOutput() {
        assertSingleHourRow(hours: [0, 5, 10, 15, 20], returns: "0000")
        assertSingleHourRow(hours: [1, 6, 11, 16, 21], returns: "R000")
        assertSingleHourRow(hours: [2, 7, 12, 17, 22], returns: "RR00")
        assertSingleHourRow(hours: [3, 8, 13, 18, 23], returns: "RRR0")
        assertSingleHourRow(hours: [4, 9, 14, 19]    , returns: "RRRR")
    }

    // MARK: - Second Lamp

    func test_secondsLamp_returnsExpectedOutput() {
        assertSecondLamp(seconds: [0, 2, 4, 8, 10], returns: "Y")
        assertSecondLamp(seconds: [1, 3, 5, 7, 9], returns: "0")
    }
}

//MARK - Helpers
extension BerlinClockTests {

    func createSut() -> (BerlinClockRepresentation, Calendar) {
        let calendar = Calendar.init(identifier: .gregorian)
        let sut = BerlinClock(calendar: calendar)

        return (sut, calendar)
    }

}
