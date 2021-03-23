//
//  BerlinClockViewControllerTests.swift
//  BerlinClockUIKitTests
//
//  Created by ***REMOVED*** on 23/03/2021.
//

import XCTest
import UIKit

final class BerlinClockViewController: UIViewController {
    private var clock: BerlinClockViewControllerTests.ClockSpy?

    convenience init(clock: BerlinClockViewControllerTests.ClockSpy) {
        self.init()
        self.clock = clock
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        clock?.format()
    }
}

final class BerlinClockViewControllerTests: XCTestCase {

    func test_init_doesNotStartTheClock() {
        let clock = ClockSpy()
        _ = BerlinClockViewController(clock: clock)

        XCTAssertEqual(clock.formatCallCount, 0)
    }

    func test_viewDidLoad_doesNotStartTheClock() {
        let clock = ClockSpy()
        let sut = BerlinClockViewController(clock: clock)

        sut.loadViewIfNeeded()

        XCTAssertEqual(clock.formatCallCount, 0)
    }

    func test_viewDidAppear_startTheClock() {
        let clock = ClockSpy()
        let sut = BerlinClockViewController(clock: clock)

        sut.viewDidAppear(false)

        XCTAssertEqual(clock.formatCallCount, 1)
    }

    // MARK: - Helpers

    class ClockSpy {
        private (set) var formatCallCount: Int = 0

        func format() {
            formatCallCount += 1
        }
    }
}
