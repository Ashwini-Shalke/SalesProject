//
//  SalesProjectUITests.swift
//  SalesProjectUITests
//
//  Created by Ashwini shalke on 18/03/21.
//

import XCTest

class SalesProjectUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        //continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testValidClick() {
        let app = XCUIApplication()
        app.launch()
        
        let tablesQuery = app.tables
        let moreInfoButton = tablesQuery.cells.containing(.staticText, identifier: "Product Name  B").buttons["More Info"]
        let textField =  tablesQuery.cells.staticTexts["Max Total Sale in Germany:64000"]
        
        XCTAssertTrue(moreInfoButton.exists)
        moreInfoButton.tap()
        XCTAssertTrue(textField.exists)
    }
    
    func testExample() throws {
//        // UI tests must launch the application that they test.
//        let app = XCUIApplication()
//        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTApplicationLaunchMetric()]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
}
