//
//  BerlinClockTimeProviderTests.swift
//  BerlinClockTests
//
//  Created by Hugo Alonso on 21/03/2021.
//

import XCTest
import BerlinClock

final class BerlinClockTimeProviderTests: XCTestCase {
    
    func test_berlinClock_reportsCorrectTimeInIntegration() {
        assertBerlinClockTime(hour: 00, minute: 00, second: 00, returns: "Y00000000000000000000000")
        assertBerlinClockTime(hour: 23, minute: 59, second: 59, returns: "0RRRRRRR0YYRYYRYYRYYYYYY")
        assertBerlinClockTime(hour: 16, minute: 50, second: 06, returns: "YRRR0R000YYRYYRYYRY00000")
        assertBerlinClockTime(hour: 11, minute: 37, second: 01, returns: "0RR00R000YYRYYRY0000YY00")
    }
    
    func assertBerlinClockTime(hour: Int, minute: Int, second: Int, from date: Date = Date(), returns expectedResult: String, file: StaticString = #file, line: UInt = #line) {
        let (sut, calendar) = createSut()
        let date = calendar.date(bySettingHour: hour, minute: minute, second: second, of: date)!
        
        let result = sut.time(for: date)
        
        XCTAssertEqual(result, expectedResult)
    }
    
    func createSut() -> (BerlinClockTimeProvider, Calendar) {
        let calendar = Calendar.init(identifier: .gregorian)
        
        let sut = BerlinClockFactory.create(
            calendar: calendar,
            colorSchema: .init(off: "0", seconds: "Y", minutes: "Y", minutesVisualAid: "R", hours: "R")
        )
        
        return (sut, calendar)
    }
}
