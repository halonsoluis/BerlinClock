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

    func test_updateTime_isInvokedWithCurrentTime() {
        let date = Date(timeIntervalSince1970: 100)
        let (sut, clock, _) = createSut(returnedDate: date)

        sut.updateTime(timer: Timer())

        XCTAssertEqual(clock.invokedTimeWithArguments.first, date)
    }

    func test_updateTime_parsesTheStringIntoColors() {
        let colorMapper = ColorMapperSpy()
        let returnedColor: CGColor = colorMapper.returnedMap
        let (sut, clock, presenter) = createSut(colorMapper: colorMapper)
        clock.stubbedUHRTime = "RRY0"

        sut.updateTime(timer: Timer())

        let expectedColors: [CGColor] = [returnedColor, returnedColor, returnedColor, returnedColor]
        XCTAssertEqual(presenter.invokedSetLampsColorWithArguments.first, expectedColors)
    }

    func test_updateTime_invokesTheColorMapperMapFunction() {
        let colorMapperSpy = ColorMapperSpy()
        let (sut, clock, _) = createSut(colorMapper: colorMapperSpy)
        clock.stubbedUHRTime = "RRY0"

        sut.updateTime(timer: Timer())

        XCTAssertEqual(colorMapperSpy.invokedMapWithArguments.count, clock.stubbedUHRTime.count)
    }

    // MARK: - Helpers

    func createSut(returnedDate: Date = Date(), colorMapper: ColorMapperSpy = ColorMapperSpy()) -> (BerlinClockViewModel, ClockSpy, PresenterSpy) {
        let clock = ClockSpy()
        let presenter = PresenterSpy()
        let dateProvider = { returnedDate }

        let sut = BerlinClockViewModel(clock: clock, dateProvider: dateProvider, colorMapper: colorMapper.map)
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

        var invokedSetLampsColorWithArguments: [[CGColor]] = []
        func setLampsColor(colors: [CGColor]) {
            invokedSetLampsColorWithArguments.append(colors)
        }
    }

    class ColorMapperSpy {
        var returnedMap = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
        var invokedMapWithArguments: [String] = []
        func map(color: String) -> CGColor {
            invokedMapWithArguments.append(color)
            return returnedMap
        }
    }
}
