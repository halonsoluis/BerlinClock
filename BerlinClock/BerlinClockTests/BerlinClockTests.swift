//
//  BerlinClockTests.swift
//  BerlinClockTests
//
//  Created by Hugo Alonso on 21/03/2021.
//

import XCTest
@testable import BerlinClock

final class BerlinClock {

    func singleMinuteRow(for date: Date) -> String {
        let calendar = Calendar.init(identifier: .gregorian)

        let minute = calendar.component(.minute, from: date)

        let amountOfLights = 4
        let iluminated = minute % 5

        var result = String(repeating: "Y", count: iluminated)
        result.append(String(repeating: "0", count: amountOfLights - iluminated))

        return result
    }

}

final class BerlinClockTests: XCTestCase {
    typealias FunctionRow = (Date) -> String

    let amountOfMultiplesOfFiveInAMinute = 60 / 5
    let fiveMinutes: TimeInterval = 5 * 60

    func test_singleMinuteRow_returnsOOOOOEveryFiveMinutesAfter0() {
        let (sut, time) = createSut(minute: 0)

        let uniqueResults = evaluateFunctionRow(
            function: sut.singleMinuteRow,
            after: time,
            every: fiveMinutes,
            repetitions: amountOfMultiplesOfFiveInAMinute
        )

        XCTAssertEqual(uniqueResults, ["0000"])
    }

    func test_singleMinuteRow_returnsOOOOOEveryFiveMinutesAfter1() {
        let (sut, time) = createSut(minute: 1)

        let uniqueResults = evaluateFunctionRow(
            function: sut.singleMinuteRow,
            after: time,
            every: fiveMinutes,
            repetitions: amountOfMultiplesOfFiveInAMinute
        )

        XCTAssertEqual(uniqueResults, ["Y000"])
    }

    func test_singleMinuteRow_returnsOOOOOEveryFiveMinutesAfter2() {
        let (sut, time) = createSut(minute: 2)

        let uniqueResults = evaluateFunctionRow(
            function: sut.singleMinuteRow,
            after: time,
            every: fiveMinutes,
            repetitions: amountOfMultiplesOfFiveInAMinute
        )

        XCTAssertEqual(uniqueResults, ["YY00"])
    }

    func test_singleMinuteRow_returnsOOOOOEveryFiveMinutesAfter3() {
        let (sut, time) = createSut(minute: 3)

        let uniqueResults = evaluateFunctionRow(
            function: sut.singleMinuteRow,
            after: time,
            every: fiveMinutes,
            repetitions: amountOfMultiplesOfFiveInAMinute
        )

        XCTAssertEqual(uniqueResults, ["YYY0"])
    }

    func test_singleMinuteRow_returnsOOOOOEveryFiveMinutesAfter4() {
        let (sut, time) = createSut(minute: 4)

        let uniqueResults = evaluateFunctionRow(
            function: sut.singleMinuteRow,
            after: time,
            every: fiveMinutes,
            repetitions: amountOfMultiplesOfFiveInAMinute
        )

        XCTAssertEqual(uniqueResults, ["YYYY"])
    }

    //MARK - Helpers

    func createSut(minute: Int, originalDate: Date = Date()) -> (BerlinClock, Date) {
        let sut = BerlinClock()

        let calendar = Calendar.init(identifier: .gregorian)
        let time = calendar.date(bySettingHour: 0, minute: minute, second: 0, of: originalDate)!

        return (sut, time)
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
