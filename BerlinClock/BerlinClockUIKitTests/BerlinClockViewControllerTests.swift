//
//  BerlinClockViewControllerTests.swift
//  BerlinClockUIKitTests
//
//  Created by ***REMOVED*** on 23/03/2021.
//

import XCTest
import UIKit
import BerlinClock

protocol ClockPresenter {
    func setLampsColor(colors: [UIColor])
}

final class BerlinClockViewController: UIViewController {
    private var interactor: BerlinClockInteractor?
    var lamps: [UIView]?

    convenience init(interactor: BerlinClockInteractor) {
        self.init()
        self.interactor = interactor
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        lamps = Array(repeating: UIView(), count: 24)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        interactor?.start()
    }
}

extension BerlinClockViewController: ClockPresenter {
    func setLampsColor(colors: [UIColor]) {

        guard let lamps = lamps else {
            return
        }

        zip(colors, lamps).forEach { (color, lamp) in
            lamp.backgroundColor = color
        }
    }
}

final class BerlinClockViewControllerTests: XCTestCase {

    func test_init_doesNotStartTheClock() {
        let interactor = BerlinClockInteractorSpy()
        _ = BerlinClockViewController(interactor: interactor)

        XCTAssertEqual(interactor.startCallCount, 0)
    }

    func test_viewDidLoad_doesNotStartTheClock() {
        let interactor = BerlinClockInteractorSpy()
        let sut = BerlinClockViewController(interactor: interactor)

        sut.loadViewIfNeeded()

        XCTAssertEqual(interactor.startCallCount, 0)
    }

    func test_viewDidLoad_preparesTheLamps() {
        let interactor = BerlinClockInteractorSpy()
        let sut = BerlinClockViewController(interactor: interactor)

        sut.loadViewIfNeeded()

        XCTAssertEqual(sut.lamps?.count, 24)
    }

    func test_setLigthsColor_applyColorToTheLamps() {
        let interactor = BerlinClockInteractorSpy()
        let sut = BerlinClockViewController(interactor: interactor)

        sut.loadViewIfNeeded()


        let lampColors = Array(repeating: UIColor.red, count: 24)
        sut.setLampsColor(colors: Array(repeating: UIColor.red, count: 24))

        XCTAssertEqual(sut.lamps?.compactMap { $0.backgroundColor }, lampColors)
    }


    func test_viewDidAppear_startTheClock() {
        let interactor = BerlinClockInteractorSpy()
        let sut = BerlinClockViewController(interactor: interactor)

        sut.viewDidAppear(false)

        XCTAssertEqual(interactor.startCallCount, 1)
    }

    // MARK: - Helpers

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
