//
//  BerlinClockViewControllerTests.swift
//  BerlinClockUIKitTests
//
//  Created by Hugo Alonso on 23/03/2021.
//

import XCTest

final class BerlinClockViewController {
    let clock: BerlinClockViewControllerTests.ClockSpy

    init(clock: BerlinClockViewControllerTests.ClockSpy) {
        self.clock = clock
    }
}

final class BerlinClockViewControllerTests: XCTestCase {

    func test_init_doesNotStartTheClock() {
        let clock = ClockSpy()
        _ = BerlinClockViewController(clock: clock)

        XCTAssertEqual(clock.formatCallCount, 0)
    }

    // MARK: - Helpers

    class ClockSpy {
        private (set) var formatCallCount: Int = 0
    }
}
