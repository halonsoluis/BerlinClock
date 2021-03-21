//
//  TestUtils.swift
//  BerlinClockTests
//
//  Created by ***REMOVED*** on 21/03/2021.
//

import XCTest

extension BerlinClockTests {

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

    func assertBerlinClockTime(hour: Int, minute: Int, second: Int, from date: Date = Date(), returns expectedResult: String, file: StaticString = #file, line: UInt = #line) {
        let (sut, calendar) = createSut()
        let date = calendar.date(bySettingHour: hour, minute: minute, second: second, of: date)!

        let result = sut.time(for: date)

        XCTAssertEqual(result, expectedResult)
    }
}
