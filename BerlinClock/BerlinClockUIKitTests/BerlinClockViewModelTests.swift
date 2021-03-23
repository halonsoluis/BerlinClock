//
//  BerlinClockViewModelTests.swift
//  BerlinClockUIKitTests
//
//  Created by ***REMOVED*** on 23/03/2021.
//

import XCTest
import BerlinClock

protocol BerlinClockInteractor {
    func start()
    func stop()
}

final class BerlinClockViewModel {
    private let clock: BerlinClockTimeProvider

    init(clock: BerlinClockTimeProvider) {
        self.clock = clock
    }
}

extension BerlinClockViewModel: BerlinClockInteractor {
    func start() {
        _ = clock.time(for: Date())
    }

    func stop() {

    }
}

final class BerlinClockViewModelTests: XCTestCase {
   
    func test_init_doesNotStartTheClock() {
        let clock = ClockSpy()
        _ = BerlinClockViewModel(clock: clock)

        XCTAssertEqual(clock.timeCallCount, 0)
    }

    func test_start_startsTheClock() {
        let clock = ClockSpy()
        let sut = BerlinClockViewModel(clock: clock)

        sut.start()

        XCTAssertEqual(clock.timeCallCount, 1)
    }

    // MARK: - Helpers

    class ClockSpy: BerlinClockTimeProvider {
        private (set) var timeCallCount: Int = 0

        func time(for date: Date) -> String {
            timeCallCount += 1
            return ""
        }
    }
}
