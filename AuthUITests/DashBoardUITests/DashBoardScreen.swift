//
//  DashBoardScreen.swift
//  AuthenticationSwiftUIUITests
//
//  Created by Muhammad Mamun on 10/12/23.
//

import Foundation
import XCTest


extension DashBoard {
    
    struct ProductScreen: Screen {
        var displayElement: XCUIElement { titleLabel }
        init() {
            waitForScreenDisplay()
        }
    }
}

fileprivate extension DashBoard.ProductScreen {
    var titleLabel: XCUIElement { app.staticTexts["DashBoard"].firstMatch }
    var loginSuccessToast: XCUIElement { app.staticTexts["loginSuccessAlert"].firstMatch }
}


extension DashBoard.ProductScreen {
   
    var loginSuccessAlertToast: String {
        loginSuccessToast.waitUntilDisplayed()
        return loginSuccessToast.label
    }
  
}
