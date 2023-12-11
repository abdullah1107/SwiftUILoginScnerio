//
//  LoginScreen.swift
//  AuthenticationSwiftUIUITests
//
//  Created by Muhammad Mamun on 9/12/23.
//

import Foundation
import XCTest


extension Login {
    
    struct LoginScreen: Screen {
        var displayElement: XCUIElement { titleLabel }
        init() {
            waitForScreenDisplay()
        }
    }
}

fileprivate extension Login.LoginScreen {
    var titleLabel: XCUIElement { app.staticTexts["login"].firstMatch }
    var userNameTextField: XCUIElement { app.textFields["usernameField"].firstMatch }
    var passwordTextField: XCUIElement { app.secureTextFields["passwordField"].firstMatch }
    var loginButton: XCUIElement { app.buttons["loginButton"].firstMatch }
    var loginFailedToast: XCUIElement { app.staticTexts["loginFailedToast"].firstMatch }
}


extension Login.LoginScreen {
    
    @discardableResult
    func tapUserTextField(_ username:String) -> Self {
        userNameTextField.waitUntilDisplayed()
        userNameTextField.tap()
        userNameTextField.typeText(username)
        return self
    }

    @discardableResult
    func tapPasswordTextField(_ password:String) -> Self {
        passwordTextField.waitUntilDisplayed()
        passwordTextField.tap()
        passwordTextField.typeText(password)
        app.buttons["Return"].tap()
        return self
    }
    
    @discardableResult
    func tapLoginButton() -> Self {
        loginButton.waitUntilDisplayed()
        loginButton.tap()
        return self
    }
    
    var loginFailedAlertToast: String {
        loginFailedToast.waitUntilDisplayed()
        return loginFailedToast.label
    }
    
    @discardableResult
    func tapLoginButtonSuccess() -> DashBoard.ProductScreen {
        loginButton.waitUntilDisplayed()
        loginButton.tap()
        waitForScreenDisplay(timeout: 2.0)
        return DashBoard.ProductScreen()
    }
}
