//
//  ThreadSafeAnimatedClockPresenterTests.swift
//  BerlinClockMainTests
//
//  Created by ***REMOVED*** on 23/03/2021.
//

import Foundation
import XCTest
@testable import BerlinClockUIKit

class ThreadSafeAnimatedClockPresenterTests: XCTestCase {
    func test_init_doesNotCallSetLamps() {
        let spy = BerlinClockViewModelTests.PresenterSpy()
        _ = ThreadSafeAnimatedClockPresenter(otherPresenter: spy)

        XCTAssertEqual(spy.invokedSetLampsColorWithArguments.count, 0)
    }

    func test_callToSetLampsColor_PassesTheDataToTheNextClockPresenter() {
        let spy = BerlinClockViewModelTests.PresenterSpy()
        let sut = ThreadSafeAnimatedClockPresenter(otherPresenter: spy)

        let colors: [RGBA] = [RGBA(red: 1, green: 1, blue: 1, alpha: 1)]
        sut.setLampsColor(colors: colors)

        XCTAssertEqual(spy.invokedSetLampsColorWithArguments, [colors])
    }
}
