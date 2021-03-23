//
//  BerlinClockViewModelTests.swift
//  BerlinClockUIKitTests
//
//  Created by ***REMOVED*** on 23/03/2021.
//

import XCTest
import BerlinClock
@testable import BerlinClockUIKit

final class BerlinClockViewModel {
    private let clock: BerlinClockTimeProvider
    var ticker: Timer?

    init(clock: BerlinClockTimeProvider) {
        self.clock = clock
    }

    @objc func updateTime(timer: Timer) {
        _ = clock.time(for: Date())
    }
}

extension BerlinClockViewModel: BerlinClockInteractor {
    func start() {
        ticker = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: updateTime)
    }

    func stop() {
        
    }
}

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
