//
//  BerlinClockRepresentationTests.swift
//  BerlinClockTests
//
//  Created by ---- ------ on 21/03/2021.
//

import XCTest
@testable import BerlinClock

final class BerlinClockRepresentationTests: XCTestCase {

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

extension BerlinClockRepresentationTests {

    func assertSingleMinuteRow(minutes: [Int], originalDate: Date = Date(), returns: String, file: StaticString = #file, line: UInt = #line) {
        let (sut, calendar) = createSut()

        let result = Set(
            minutes
                .map { calendar.date(bySettingHour: 0, minute: $0, second: 0, of: originalDate)! }
                .map(sut.singleMinuteRow)
        )

        XCTAssertEqual(result.count, 1, file: file, line: line)
        XCTAssertEqual(result.first!, returns, file: file, line: line)
    }

    func assertSingleHourRow(hours: [Int], originalDate: Date = Date(), returns: String, file: StaticString = #file, line: UInt = #line) {
        let (sut, calendar) = createSut()

        let result = Set(
            hours
                .map { calendar.date(bySettingHour: $0, minute: 0, second: 0, of: originalDate)! }
                .map(sut.singleHourRow)
        )

        XCTAssertEqual(result.count, 1, file: file, line: line)
        XCTAssertEqual(result.first!, returns, file: file, line: line)
    }

    func assertFiveMinuteRow(minutes: ClosedRange<Int>, returns: String, originalDate: Date = Date(), file: StaticString = #file, line: UInt = #line) {
        let (sut, calendar) = createSut()

        let result = Set(
            minutes
                .map { calendar.date(bySettingHour: 0, minute: $0, second: 0, of: originalDate)! }
                .map(sut.fiveMinuteRow)
        )

        XCTAssertEqual(result.count, 1, "Expected a unique set of results", file: file, line: line)
        XCTAssertEqual(result.first!, returns, file: file, line: line)
    }

    func assertFiveHourRow(hours: ClosedRange<Int>, returns: String, originalDate: Date = Date(), file: StaticString = #file, line: UInt = #line) {
        let (sut, calendar) = createSut()

        let result = Set(
            hours
                .map { calendar.date(bySettingHour: $0, minute: 0, second: 0, of: originalDate)! }
                .map(sut.fiveHourRow)
        )

        XCTAssertEqual(result.count, 1, "Expected a unique set of results", file: file, line: line)
        XCTAssertEqual(result.first!, returns, file: file, line: line)
    }

    func assertSecondLamp(seconds: [Int], returns: String, originalDate: Date = Date(), file: StaticString = #file, line: UInt = #line) {
        let (sut, calendar) = createSut()

        let result = Set(
            seconds
                .map { calendar.date(bySettingHour: 0, minute: 0, second: $0, of: originalDate)! }
                .map(sut.secondsLamp)
        )

        XCTAssertEqual(result.count, 1, "Expected a unique set of results", file: file, line: line)
        XCTAssertEqual(result.first!, returns, file: file, line: line)
    }
}


//MARK - Helpers
extension BerlinClockRepresentationTests {

    func createSut() -> (BerlinClockRepresentation, Calendar) {
        let calendar = Calendar.init(identifier: .gregorian)
        
        let sut = BerlinClockDateFormatter(
            berlinClock: BerlinClock(calendar: calendar),
            colorSchema: .init(off: "0", seconds: "Y", minutes: "Y", minutesVisualAid: "R", hours: "R")
        )
        return (sut, calendar)
    }
}
