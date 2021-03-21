//
//  BerlinClockTests.swift
//  BerlinClockTests
//
//  Created by ***REMOVED*** on 21/03/2021.
//

import XCTest
@testable import BerlinClock

protocol BerlinClockRepresentation {
    func singleMinuteRow(for date: Date) -> String
    func fiveMinuteRow(for date: Date) -> String
    func fiveHourRow(for date: Date) -> String
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

    private func fiveHourRow(for date: Date) -> [Bool] {
        calculateLights(
            total: 4,
            iluminated: extractHour(from: date) / 5
        )
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
}

final class BerlinClockTests: XCTestCase {

    // MARK: - Single Minutes Row
    
    func test_singleMinuteRow_returnsExpectedOutput() {
        let sixtyCountsAs0 = 1
        let cases = (60 / 5) - sixtyCountsAs0
        let multip = (0...cases).map { $0 * 5 }

        assertSingleMinuteRow(minutes: multip.map { $0 + 0 }, returns: "0000")
        assertSingleMinuteRow(minutes: multip.map { $0 + 1 }, returns: "Y000")
        assertSingleMinuteRow(minutes: multip.map { $0 + 2 }, returns: "YY00")
        assertSingleMinuteRow(minutes: multip.map { $0 + 3 }, returns: "YYY0")
        assertSingleMinuteRow(minutes: multip.map { $0 + 4 }, returns: "YYYY")
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
}

//MARK - Helpers
extension BerlinClockTests {

    func createSut(second: Int = 0, minute: Int = 0, hour: Int = 0) -> (BerlinClockRepresentation, Calendar) {
        let calendar = Calendar.init(identifier: .gregorian)
        let sut = BerlinClock(calendar: calendar)

        return (sut, calendar)
    }

}
