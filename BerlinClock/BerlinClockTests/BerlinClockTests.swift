//
//  BerlinClockTests.swift
//  BerlinClockTests
//
//  Created by ***REMOVED*** on 21/03/2021.
//

import XCTest
@testable import BerlinClock

final class BerlinClock {

    func singleMinuteRow(for date: Date) -> String {
        let calendar = Calendar.init(identifier: .gregorian)

        let minute = calendar.component(.minute, from: date)

        let value = minute % 5

        switch value {
        case 0: return "0000"
        case 1: return "Y000"
        case 2: return "YY00"
        case 3: return "YYY0"
        case 4: return "YYYY"
        default:
            assertionFailure("There should not be a case hitting here")
        }
        return ""
    }

}

final class BerlinClockTests: XCTestCase {
    let amountOfMultiplesOfFiveInAMinute = 60 / 5
    let fiveMinutes: TimeInterval = 5 * 60

    func test_singleMinuteRow_returnsOOOOOEveryFiveMinutesAfter0() {
        let (sut, time) = createSut(minute: 0)

        let uniqueResults = evaluateSingleMinuteRow(
            using: sut,
            after: time,
            every: fiveMinutes,
            repetitions: amountOfMultiplesOfFiveInAMinute
        )

        XCTAssertEqual(uniqueResults, ["0000"])
    }

    func test_singleMinuteRow_returnsOOOOOEveryFiveMinutesAfter1() {
        let (sut, time) = createSut(minute: 1)

        let uniqueResults = evaluateSingleMinuteRow(
            using: sut,
            after: time,
            every: fiveMinutes,
            repetitions: amountOfMultiplesOfFiveInAMinute
        )

        XCTAssertEqual(uniqueResults, ["Y000"])
    }

    func test_singleMinuteRow_returnsOOOOOEveryFiveMinutesAfter2() {
        let (sut, time) = createSut(minute: 2)

        let uniqueResults = evaluateSingleMinuteRow(
            using: sut,
            after: time,
            every: fiveMinutes,
            repetitions: amountOfMultiplesOfFiveInAMinute
        )

        XCTAssertEqual(uniqueResults, ["YY00"])
    }

    func test_singleMinuteRow_returnsOOOOOEveryFiveMinutesAfter3() {
        let (sut, time) = createSut(minute: 3)

        let uniqueResults = evaluateSingleMinuteRow(
            using: sut,
            after: time,
            every: fiveMinutes,
            repetitions: amountOfMultiplesOfFiveInAMinute
        )

        XCTAssertEqual(uniqueResults, ["YYY0"])
    }

    func test_singleMinuteRow_returnsOOOOOEveryFiveMinutesAfter4() {
        let (sut, time) = createSut(minute: 4)

        let uniqueResults = evaluateSingleMinuteRow(
            using: sut,
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

    func evaluateSingleMinuteRow(using sut: BerlinClock,
                                 after time: Date,
                                 every interval: TimeInterval,
                                 repetitions: Int) -> Set<String> {
        var result = [String]()
        (0...repetitions).forEach { (_) in
            result.append(sut.singleMinuteRow(for: time.addingTimeInterval(interval)))
        }
        return Set(result)
    }
}
