//
//  BaseTestCase.swift
//  AuthenticationSwiftUIUITests
//
//  Created by Muhammad Mamun on 9/12/23.
//

import XCTest

class BaseXCTestSetup: XCTestCase {

    override func setUpWithError() throws {
        try super.setUpWithError()
        let app = XCUIApplication()
        app.launchArguments.append("--uitesting")
        // Put setup code here. This method is called before the invocation of each test method in the class.
        app.launch()
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    override func tearDownWithError() throws {
        try? super.tearDownWithError()
    }
}
