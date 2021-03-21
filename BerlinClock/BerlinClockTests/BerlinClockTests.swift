//
//  BerlinClockTests.swift
//  BerlinClockTests
//
//  Created by ***REMOVED*** on 21/03/2021.
//

import XCTest
@testable import BerlinClock

final class BerlinClock {

    let calendar: Calendar

    init(calendar: Calendar = .init(identifier: .gregorian)) {
        self.calendar = calendar
    }

    func singleMinuteRow(for date: Date) -> String {
        return singleMinuteRow(for: date).map { $0 ? "Y" : "0" }.joined()
    }

    func fiveMinuteRow(for date: Date) -> String {
        return fiveMinuteRow(for: date).map { $0 ? "Y" : "0" }.joined()
    }

    private func fiveMinuteRow(for date: Date) -> [Bool] {
        let minute = calendar.component(.minute, from: date)
        return fiveMinuteRow(for: minute)
    }

    private func fiveMinuteRow(for minute: Int) -> [Bool] {
        let amountOfLights = 11
        let iluminated = minute / 5

        let onLights = Array(repeating: true, count: iluminated)
        let offLights = Array(repeating: false, count: amountOfLights - iluminated)

        return onLights + offLights
    }

    private func singleMinuteRow(for date: Date) -> [Bool] {
        let minute = calendar.component(.minute, from: date)
        return singleMinuteRow(for: minute)
    }

    private func singleMinuteRow(for minute: Int) -> [Bool] {
        let amountOfLights = 4
        let iluminated = minute % 5

        let onLights = Array(repeating: true, count: iluminated)
        let offLights = Array(repeating: false, count: amountOfLights - iluminated)

        return onLights + offLights
    }

}

final class BerlinClockTests: XCTestCase {
    typealias FunctionRow = (Date) -> String

    // MARK: - Single Minutes Row

    func test_singleMinuteRow_returnsOOOOEveryFiveMinutesAfter1() {
        assertSingleMinuteRow(every5MinutesAfter: 0, returns: "0000")
    }

    func test_singleMinuteRow_returnsYOOOEveryFiveMinutesAfter1() {
        assertSingleMinuteRow(every5MinutesAfter: 1, returns: "Y000")
    }

    func test_singleMinuteRow_returnsYY00EveryFiveMinutesAfter2() {
        assertSingleMinuteRow(every5MinutesAfter: 2, returns: "YY00")
    }

    func test_singleMinuteRow_returnsYYY0EveryFiveMinutesAfter3() {
        assertSingleMinuteRow(every5MinutesAfter: 3, returns: "YYY0")
    }

    func test_singleMinuteRow_returnsYYYYEveryFiveMinutesAfter4() {
        assertSingleMinuteRow(every5MinutesAfter: 4, returns: "YYYY")
    }

    // MARK: - Five Minutes Row

    func test_fiveMinuteRow_returnsOOOOOOOOOOOAtMinute0() {
        assertFiveMinuteRow(at: 0, returns: "00000000000")
    }

    func test_fiveMinuteRow_returnsYOOOOOOOOOOAtMinute5() {
        assertFiveMinuteRow(at: 5, returns: "Y0000000000")
    }

    func test_fiveMinuteRow_returnsYOOOOOOOOOOAtMinute10() {
        assertFiveMinuteRow(at: 10, returns: "YY000000000")
    }

    //MARK - Helpers

    func createSut(minute: Int, originalDate: Date = Date()) -> (BerlinClock, Date) {
        let calendar = Calendar.init(identifier: .gregorian)
        let sut = BerlinClock(calendar: calendar)

        let time = calendar.date(bySettingHour: 0, minute: minute, second: 0, of: originalDate)!

        return (sut, time)
    }

    func assertFiveMinuteRow(at minute: Int, returns: String, file: StaticString = #file, line: UInt = #line) {
        let (sut, time) = createSut(minute: minute)
        let minute: TimeInterval = 60

        let uniqueResults = evaluateFunctionRow(
            function: sut.fiveMinuteRow,
            after: time,
            every: minute,
            repetitions: 4
        )

        XCTAssertEqual(uniqueResults.count, 1, "Expected a unique set of results", file: file, line: line)
        XCTAssertEqual(uniqueResults.first!, returns, file: file, line: line)
    }

    func assertSingleMinuteRow(every5MinutesAfter minute: Int, returns: String, file: StaticString = #file, line: UInt = #line) {
        let (sut, time) = createSut(minute: minute)

        let amountOfMultiplesOfFiveInAMinute = 60 / 5
        let fiveMinutes: TimeInterval = 5 * 60

        let uniqueResults = evaluateFunctionRow(
            function: sut.singleMinuteRow,
            after: time,
            every: fiveMinutes,
            repetitions: amountOfMultiplesOfFiveInAMinute
        )

        XCTAssertEqual(uniqueResults.count, 1, file: file, line: line)
        XCTAssertEqual(uniqueResults.first!, returns, file: file, line: line)
    }

    func evaluateFunctionRow(function: FunctionRow,
                             after time: Date,
                             every interval: TimeInterval,
                             repetitions: Int) -> Set<String> {
        var result = [String]()
        var movingWindow = time

        (0...repetitions).forEach { (_) in
            result.append(function(movingWindow))
            movingWindow = movingWindow.addingTimeInterval(interval)
        }

        return Set(result)
    }
}
