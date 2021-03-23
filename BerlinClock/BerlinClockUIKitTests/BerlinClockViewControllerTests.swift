//
//  BerlinClockViewControllerTests.swift
//  BerlinClockUIKitTests
//
//  Created by Hugo Alonso on 23/03/2021.
//

import XCTest
import UIKit
@testable import BerlinClockUIKit

final class BerlinClockViewControllerTests: XCTestCase {

    func test_init_doesNotStartTheClock() {
        let (_, interactor) = createSut()

        XCTAssertEqual(interactor.startCallCount, 0)
    }

    func test_viewDidLoad_doesNotStartTheClock() {
        let (sut, interactor) = createSut()

        sut.loadViewIfNeeded()

        XCTAssertEqual(interactor.startCallCount, 0)
    }

    func test_viewDidLoad_preparesTheLamps() {
        let (sut, _) = createSut()

        sut.loadViewIfNeeded()

        XCTAssertEqual(sut.lamps?.count, 24)
    }

    func test_setLigthsColor_applyColorToTheLamps() {
        let (sut, _) = createSut()

        sut.loadViewIfNeeded()

        let lampColors = Array(repeating: UIColor.red, count: 24)
        sut.setLampsColor(colors: Array(repeating: RGBA(red: 1, green: 0, blue: 0, alpha: 1), count: 24))

        XCTAssertEqual(sut.lamps?.compactMap { $0.backgroundColor }, lampColors)
    }


    func test_viewDidAppear_startTheClock() {
        let (sut, interactor) = createSut()

        sut.viewDidAppear(false)

        XCTAssertEqual(interactor.startCallCount, 1)
    }

    func test_viewWillDisappear_stopsTheClock() {
        let (sut, interactor) = createSut()

        sut.viewWillDisappear(false)

        XCTAssertEqual(interactor.stopCallCount, 1)
    }

    // MARK: - Helpers

    func createSut() -> (BerlinClockViewController, BerlinClockInteractorSpy) {
        let interactor = BerlinClockInteractorSpy()
        let sut = BerlinClockViewController()
        sut.connect(interactor: interactor)

        return (sut, interactor)
    }

    class BerlinClockInteractorSpy: BerlinClockInteractor {
        private (set) var startCallCount: Int = 0
        private (set) var stopCallCount: Int = 0

        func start() {
            startCallCount += 1
        }
        func stop() {
            stopCallCount += 1
        }
    }
}
