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

    func test_visualsOfTheClock_arePresent() throws {

        let app = XCUIApplication()
        app.launch()

        let expectedIdentifiers = [
            "seconds",
            "hour5",
            "hour10",
            "hour15",
            "hour20",
            "hour1",
            "hour2",
            "hour3",
            "hour4",
            "minute1",
            "minute2",
            "minute3",
            "minute4",
            "minute5",
            "minute10",
            "minute15",
            "minute20",
            "minute25",
            "minute30",
            "minute35",
            "minute40",
            "minute45",
            "minute50",
            "minute55",
        ]

        expectedIdentifiers.forEach { identifier in
            checkVisualExists(identifier: identifier, on: app)
        }
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }

    // MARK: - Helpers

    private func checkVisualExists(identifier: String, on app: XCUIApplication, file: StaticString = #file, line: UInt = #line) {

        let element = app.otherElements[identifier]
        XCTAssertTrue(element.exists, "Expected to find \(identifier)")
    }
}
