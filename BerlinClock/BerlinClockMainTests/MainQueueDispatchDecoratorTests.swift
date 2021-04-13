//
//  ThreadSafeAnimatedClockPresenterTests.swift
//  BerlinClockMainTests
//
//  Created by Hugo Alonso on 23/03/2021.
//

import Foundation
import XCTest
import BerlinClockUIKit
@testable import BerlinClockMain

class MainQueueDispatchDecoratorTests: XCTestCase {
    func test_init_doesNotCallSetLamps() {
        let spy = PresenterSpy()
        _ = MainQueueDispatchDecorator(decoratee: spy)

        XCTAssertEqual(spy.invokedSetLampsColorWithArguments.count, 0)
    }

    func test_callToSetLampsColor_PassesTheDataToTheNextClockPresenter() {
        let spy = PresenterSpy()
        let sut: ClockPresenter = MainQueueDispatchDecorator(decoratee: spy)

        let colors: [CGColor] = [UIColor.white.cgColor]
        sut.setLampsColor(colors: colors)

        XCTAssertEqual(spy.invokedSetLampsColorWithArguments, [colors])
    }

    //MARK: - Helpers

    class PresenterSpy: ClockPresenter {
        var invokedSetLampsColorWithArguments: [[CGColor]] = []
        func setLampsColor(colors: [CGColor]) {
            invokedSetLampsColorWithArguments.append(colors)
        }
    }
}
