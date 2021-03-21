//
//  TestUtils.swift
//  BerlinClockTests
//
//  Created by ***REMOVED*** on 21/03/2021.
//

import XCTest

extension BerlinClockTests {

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

    func assertFiveMinuteRow(inTheNext4minutesAfter minute: Int, returns: String, file: StaticString = #file, line: UInt = #line) {
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

    func evaluateFunctionRow(function: (Date) -> String,
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
