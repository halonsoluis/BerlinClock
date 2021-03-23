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
        let (_, clock) = createSut()

        XCTAssertEqual(clock.timeCallCount, 0)
    }

    func test_start_startsTheClock() {
        let (sut, clock) = createSut()

        sut.start()

        XCTAssertEqual(clock.timeCallCount, 1)
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
