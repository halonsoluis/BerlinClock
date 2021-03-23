//
//  BerlinClockMainUITests.swift
//  BerlinClockMainUITests
//
//  Created by ***REMOVED*** on 23/03/2021.
//

import XCTest

class BerlinClockMainUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_visualForSeconds_isPresent() throws {

        let app = XCUIApplication()
        app.launch()

        checkVisualExists(identifier: "seconds", on: app)
    }

    func test_visualForHour5_isPresent() throws {

        let app = XCUIApplication()
        app.launch()

        checkVisualExists(identifier: "hour5", on: app)
    }

    private func checkVisualExists(identifier: String, on app: XCUIApplication, file: StaticString = #file, line: UInt = #line) {

        let element = app.otherElements[identifier]
        XCTAssertTrue(element.exists)
    }


    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
