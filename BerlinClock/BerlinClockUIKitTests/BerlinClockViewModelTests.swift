//
//  BerlinClockViewModelTests.swift
//  BerlinClockUIKitTests
//
//  Created by ***REMOVED*** on 23/03/2021.
//
import XCTest
import BerlinClock
@testable import BerlinClockUIKit

final class BerlinClockViewModelTests: XCTestCase {
   
    func test_init_doesNotStartTheClock() {
        let (sut, clock) = createSut()

        XCTAssertNil(sut.ticker)
        XCTAssertEqual(clock.timeCallCount, 0)
    }

    func test_start_startsTheClock() {
        let (sut, clock) = createSut()

        sut.start()

        XCTAssertNotNil(sut.ticker)
        XCTAssertEqual(clock.timeCallCount, 0)
        XCTAssertTrue(sut.ticker!.isValid)
    }

    func test_stop_stopsTheClock() {
        let (sut, _) = createSut()

        sut.start()
        sut.stop()

        XCTAssertFalse(sut.ticker!.isValid)
    }

    // MARK: - Helpers

    func createSut() -> (BerlinClockViewModel, ClockSpy) {
        let clock = ClockSpy()
        let sut = BerlinClockViewModel(clock: clock)

        return (sut, clock)
    }

    class ClockSpy: BerlinClockTimeProvider {
        private (set) var timeCallCount: Int = 0

        func time(for date: Date) -> String {
            timeCallCount += 1
            return ""
        }
    }
}
