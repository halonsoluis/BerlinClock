//
//  TickerFactoryImplementationTests.swift
//  BerlinClockUIKitTests
//
//  Created by Hugo Alonso on 12/04/2021.
//

import XCTest
@testable import BerlinClockUIKit

final class TickerFactoryImplementationTests: XCTestCase {

    func test_execute_createsValidTimer() {
        let tickerFactory = createSUT()

        let timer = tickerFactory.execute(block: {}, every: 10)

        XCTAssertTrue(timer.isValid)
        XCTAssertEqual(timer.timeInterval, 10)
    }

    func test_execute_createsTimerThatExecutesBlock() {
        let tickerFactory = createSUT()

        var blockFired = false
        let timer = tickerFactory.execute(
            block: { blockFired = true },
            every: 10
        )

        timer.fire()

        XCTAssertTrue(blockFired)
    }

    func test_stop_invalidatesTheTimer() {
        let tickerFactory = createSUT()

        let timer = tickerFactory.execute(block: {}, every: 10)

        tickerFactory.stop(ticker: timer)
        XCTAssertFalse(timer.isValid)
    }

    func createSUT() -> TickerFactory {
        return TickerFactoryImplementation()
    }
}

