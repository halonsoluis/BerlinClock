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

    func test_singleMinuteRow_returnsOOOOOEveryFiveMinutesAfter0() {
        assertSingleMinuteRow(every5MinutesAfter: 0, returns: "0000")
    }

    func test_singleMinuteRow_returnsOOOOOEveryFiveMinutesAfter1() {
        assertSingleMinuteRow(every5MinutesAfter: 1, returns: "Y000")
    }

    func test_singleMinuteRow_returnsOOOOOEveryFiveMinutesAfter2() {
        assertSingleMinuteRow(every5MinutesAfter: 2, returns: "YY00")
    }

    func test_singleMinuteRow_returnsOOOOOEveryFiveMinutesAfter3() {
        assertSingleMinuteRow(every5MinutesAfter: 3, returns: "YYY0")
    }

    func test_singleMinuteRow_returnsOOOOOEveryFiveMinutesAfter4() {
        assertSingleMinuteRow(every5MinutesAfter: 4, returns: "YYYY")
    }

    //MARK - Helpers

    func createSut(minute: Int, originalDate: Date = Date()) -> (BerlinClock, Date) {
        let calendar = Calendar.init(identifier: .gregorian)
        let sut = BerlinClock(calendar: calendar)

        let time = calendar.date(bySettingHour: 0, minute: minute, second: 0, of: originalDate)!

        return (sut, time)
    }

    func assertSingleMinuteRow(every5MinutesAfter minute: Int, returns: String) {
        let (sut, time) = createSut(minute: minute)

        let amountOfMultiplesOfFiveInAMinute = 60 / 5
        let fiveMinutes: TimeInterval = 5 * 60

        let uniqueResults = evaluateFunctionRow(
            function: sut.singleMinuteRow,
            after: time,
            every: fiveMinutes,
            repetitions: amountOfMultiplesOfFiveInAMinute
        )

        XCTAssertEqual(uniqueResults, [returns])
    }

    func evaluateFunctionRow(function: FunctionRow,
                             after time: Date,
                             every interval: TimeInterval,
                             repetitions: Int) -> Set<String> {
        var result = [String]()
        (0...repetitions).forEach { (_) in
            result.append(
                function(time.addingTimeInterval(interval))
            )
        }
        return Set(result)
    }
}
