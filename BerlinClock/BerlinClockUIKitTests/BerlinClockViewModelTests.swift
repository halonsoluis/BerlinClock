//
//  BerlinClockViewModelTests.swift
//  BerlinClockUIKitTests
//
//  Created by Hugo Alonso on 23/03/2021.
//

import XCTest
import BerlinClock

final class BerlinClockViewModel {
    private var clock: BerlinClockTimeProvider?

    init(clock: BerlinClockTimeProvider) {
        self.clock = clock
    }
}

final class BerlinClockViewModelTests {
   
    func test_init_doesNotStartTheClock() {
        let clock = ClockSpy()
        _ = BerlinClockViewController(clock: clock)

        XCTAssertEqual(clock.timeCallCount, 0)
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
