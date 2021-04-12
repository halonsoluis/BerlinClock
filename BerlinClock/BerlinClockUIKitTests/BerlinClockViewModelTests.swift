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
        let (_, clock, _, ticker) = createSut()

        XCTAssertEqual(ticker.invokedExecuteWithArguments.count, 0)
        XCTAssertEqual(ticker.invokedStopWithArguments.count, 0)
        XCTAssertEqual(clock.invokedTimeWithArguments.count, 0)
    }

    func test_start_startsTheClock() {
        let (sut, clock, _, ticker) = createSut()

        sut.start()


        XCTAssertEqual(ticker.invokedExecuteWithArguments.count, 1)
        XCTAssertEqual(ticker.invokedStopWithArguments.count, 0)
        XCTAssertEqual(clock.invokedTimeWithArguments.count, 0)
    }

    func test_stop_stopsTheClock() {
        let (sut, _, _, ticker) = createSut()

        ticker.stubbedTicker = Timer(
            timeInterval: 10, repeats: true, block: { _ in }
        )
        sut.start()
        sut.stop()

        XCTAssertEqual(ticker.invokedExecuteWithArguments.count, 1)
        XCTAssertEqual(ticker.invokedStopWithArguments.count, 1)
    }

    func test_updateTime_attemptsToFormatTheTime() {
        let (sut, clock, _, _) = createSut()

        sut.updateTime()

        XCTAssertEqual(clock.invokedTimeWithArguments.count, 1)
    }

    func test_updateTime_attemptsToInvokeAnUIUpdate() {
        let (sut, _, presenter, _) = createSut()

        sut.updateTime()

        XCTAssertEqual(presenter.invokedSetLampsColorWithArguments.count, 1)
    }

    func test_updateTime_isInvokedWithCurrentTime() {
        let date = Date(timeIntervalSince1970: 100)
        let (sut, clock, _, _) = createSut(returnedDate: date)

        sut.updateTime()

        XCTAssertEqual(clock.invokedTimeWithArguments.first, date)
    }

    func test_updateTime_parsesTheStringIntoColors() {
        let colorMapper = ColorMapperSpy()
        let returnedColor: CGColor = colorMapper.returnedMap
        let (sut, clock, presenter, _) = createSut(colorMapper: colorMapper)
        clock.stubbedUHRTime = "RRY0"

        sut.updateTime()

        let expectedColors: [CGColor] = [returnedColor, returnedColor, returnedColor, returnedColor]
        XCTAssertEqual(presenter.invokedSetLampsColorWithArguments.first, expectedColors)
    }

    func test_updateTime_invokesTheColorMapperMapFunction() {
        let colorMapperSpy = ColorMapperSpy()
        let (sut, clock, _, _) = createSut(colorMapper: colorMapperSpy)
        clock.stubbedUHRTime = "RRY0"

        sut.updateTime()

        XCTAssertEqual(colorMapperSpy.invokedMapWithArguments.count, clock.stubbedUHRTime.count)
    }

    // MARK: - Helpers

    func createSut(returnedDate: Date = Date(),
                   colorMapper: ColorMapperSpy = ColorMapperSpy()
    ) -> (BerlinClockViewModel, ClockSpy, PresenterSpy, TickerFactorySpy) {
        let clock = ClockSpy()
        let presenter = PresenterSpy()
        let dateProvider = { returnedDate }
        let tickerProvider = TickerFactorySpy()

        let sut = BerlinClockViewModel(
            clock: clock,
            dateProvider: dateProvider,
            colorMapper: colorMapper.map,
            tickerFactory: tickerProvider
        )
        sut.presenter = presenter

        return (sut, clock, presenter, tickerProvider)
    }

    class TickerFactorySpy: TickerFactory {
        var invokedStopWithArguments: [Timer] = []
        func stop(ticker: Timer) {
            invokedStopWithArguments.append(ticker)
        }

        var invokedExecuteWithArguments: [(() -> Void, TimeInterval)] = []
        var stubbedTicker: Timer = Timer()
        func execute(block: @escaping () -> Void, every interval: TimeInterval) -> Timer {
            invokedExecuteWithArguments.append((block, interval))
            return stubbedTicker
        }
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
        var invokedMapWithArguments: [Character] = []
        func map(color: Character) -> CGColor {
            invokedMapWithArguments.append(color)
            return returnedMap
        }
    }
}
