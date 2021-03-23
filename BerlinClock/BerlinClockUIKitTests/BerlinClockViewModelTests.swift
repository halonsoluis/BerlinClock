//
//  BerlinClockViewModelTests.swift
//  BerlinClockUIKitTests
//
//  Created by Hugo Alonso on 23/03/2021.
//
import XCTest
import BerlinClock
@testable import BerlinClockUIKit

final class BerlinClockViewModelTests: XCTestCase {
   
    func test_init_doesNotStartTheClock() {
        let (sut, clock, _) = createSut()

        XCTAssertNil(sut.ticker)
        XCTAssertEqual(clock.invokedTimeWithArguments.count, 0)
    }

    func test_start_startsTheClock() {
        let (sut, clock, _) = createSut()

        sut.start()

        XCTAssertNotNil(sut.ticker)
        XCTAssertEqual(clock.invokedTimeWithArguments.count, 0)
        XCTAssertTrue(sut.ticker!.isValid)
    }

    func test_stop_stopsTheClock() {
        let (sut, _, _) = createSut()

        sut.start()
        sut.stop()

        XCTAssertFalse(sut.ticker!.isValid)
    }

    func test_updateTime_attemptsToFormatTheTime() {
        let (sut, clock, _) = createSut()

        sut.updateTime(timer: Timer())

        XCTAssertEqual(clock.invokedTimeWithArguments.count, 1)
    }

    func test_updateTime_attemptsToInvokeAnUIUpdate() {
        let (sut, _, presenter) = createSut()

        sut.updateTime(timer: Timer())

        XCTAssertEqual(presenter.invokedSetLampsColorWithArguments.count, 1)
    }

    // MARK: - Helpers

    func createSut(returnedDate: Date = Date()) -> (BerlinClockViewModel, ClockSpy, PresenterSpy) {
        let clock = ClockSpy()
        let presenter = PresenterSpy()
        let dateProvider = { returnedDate }
        let sut = BerlinClockViewModel(clock: clock, dateProvider: dateProvider)
        sut.presenter = presenter

        return (sut, clock, presenter)
    }

    class ClockSpy: BerlinClockTimeProvider {
        var invokedTimeWithArguments: [Date] = []
        var stubbedUHRTime: String = "YR0"
        func time(for date: Date) -> String {
            invokedTimeWithArguments.append(date)
            return stubbedUHRTime
        }
    }

    class PresenterSpy: ClockPresenter {

        var invokedSetLampsColorWithArguments: [[UIColor]] = []
        func setLampsColor(colors: [UIColor]) {
            invokedSetLampsColorWithArguments.append(colors)
        }

        private (set) var timeCallCount: Int = 0

        func time(for date: Date) -> String {
            timeCallCount += 1
            return ""
        }
    }
}
