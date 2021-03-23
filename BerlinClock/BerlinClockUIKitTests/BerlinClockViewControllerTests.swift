//
//  BerlinClockViewControllerTests.swift
//  BerlinClockUIKitTests
//
//  Created by Hugo Alonso on 23/03/2021.
//

import XCTest
import UIKit
import BerlinClock

final class BerlinClockViewController: UIViewController {
    private var clock: BerlinClockTimeProvider?

    convenience init(clock: BerlinClockTimeProvider) {
        self.init()
        self.clock = clock
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        _ = clock?.time(for: Date())
    }
}

final class BerlinClockViewControllerTests: XCTestCase {

    func test_init_doesNotStartTheClock() {
        let clock = ClockSpy()
        _ = BerlinClockViewController(clock: clock)

        XCTAssertEqual(clock.timeCallCount, 0)
    }

    func test_viewDidLoad_doesNotStartTheClock() {
        let clock = ClockSpy()
        let sut = BerlinClockViewController(clock: clock)

        sut.loadViewIfNeeded()

        XCTAssertEqual(clock.timeCallCount, 0)
    }

    func test_viewDidAppear_startTheClock() {
        let clock = ClockSpy()
        let sut = BerlinClockViewController(clock: clock)

        sut.viewDidAppear(false)

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
