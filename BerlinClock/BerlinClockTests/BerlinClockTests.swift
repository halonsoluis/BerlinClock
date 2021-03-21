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

        if minute == 0 {
            return "0000"
        } else {
            return "Y000"
        }
    }

}

final class BerlinClockTests: XCTestCase {
    func test_singleMinuteRow_returnsOOOOforFirstMomentOfTheDay() {
        let (sut, time) = createSut(minute: 0)

        let result = sut.singleMinuteRow(for: time)

        XCTAssertEqual(result, "0000")
    }

    func test_singleMinuteRow_returnsYOOOforSecondMinuteOfTheDay() {
        let (sut, time) = createSut(minute: 1)

        let result = sut.singleMinuteRow(for: time)

        XCTAssertEqual(result, "Y000")
    }

    //MARK - Helpers

    func createSut(minute: Int, originalDate: Date = Date()) -> (BerlinClock, Date) {
        let sut = BerlinClock()

        let calendar = Calendar.init(identifier: .gregorian)
        let time = calendar.date(bySettingHour: 0, minute: minute, second: 0, of: originalDate)!

        return (sut, time)
    }
}
