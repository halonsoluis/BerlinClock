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
            assertionFailure("There should no be a case hitting here")
        }
        return ""
    }

}

final class BerlinClockTests: XCTestCase {
    func test_singleMinuteRow_returnsOOOOOEveryFiveMinutesAfter0() {
        let amountOfMultiplesOfFiveInAMinute = 60 / 5
        let (sut, time) = createSut(minute: 0)

        var result = [String]()
        (0...amountOfMultiplesOfFiveInAMinute).forEach { (_) in
            result.append(sut.singleMinuteRow(for: time.addingTimeInterval(5)))
        }
        let uniqueResults = Set(result)

        XCTAssertEqual(uniqueResults, ["0000"])
    }

    func test_singleMinuteRow_returnsYOOOforFifthMinuteOfTheDay() {
        let (sut, time) = createSut(minute: 5)

        let result = sut.singleMinuteRow(for: time)

        XCTAssertEqual(result, "0000")
    }

    func test_singleMinuteRow_returnsYOOOforFirstMinuteOfTheDay() {
        let (sut, time) = createSut(minute: 1)

        let result = sut.singleMinuteRow(for: time)

        XCTAssertEqual(result, "Y000")
    }

    func test_singleMinuteRow_returnsYOOOforSixthMinuteOfTheDay() {
        let (sut, time) = createSut(minute: 6)

        let result = sut.singleMinuteRow(for: time)

        XCTAssertEqual(result, "Y000")
    }

    func test_singleMinuteRow_returnsYOOOforSecondMinuteOfTheDay() {
        let (sut, time) = createSut(minute: 2)

        let result = sut.singleMinuteRow(for: time)

        XCTAssertEqual(result, "YY00")
    }

    func test_singleMinuteRow_returnsYOOOforThirdMinuteOfTheDay() {
        let (sut, time) = createSut(minute: 3)

        let result = sut.singleMinuteRow(for: time)

        XCTAssertEqual(result, "YYY0")
    }

    func test_singleMinuteRow_returnsYOOOforFourthMinuteOfTheDay() {
        let (sut, time) = createSut(minute: 4)

        let result = sut.singleMinuteRow(for: time)

        XCTAssertEqual(result, "YYYY")
    }

    //MARK - Helpers

    func createSut(minute: Int, originalDate: Date = Date()) -> (BerlinClock, Date) {
        let sut = BerlinClock()

        let calendar = Calendar.init(identifier: .gregorian)
        let time = calendar.date(bySettingHour: 0, minute: minute, second: 0, of: originalDate)!

        return (sut, time)
    }
}
