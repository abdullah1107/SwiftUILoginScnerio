//
//  LoginTest.swift
//  AuthenticationSwiftUIUITests
//
//  Created by Muhammad Mamun on 9/12/23.
//

import XCTest

final class LoginTest: BaseXCTestSetup {

    func testLoginWithInvalidCredentials() {
        Login.LoginScreen()
            .tapUserTextField("Mamun")
            .tapPasswordTextField("dfuiu&")
            .tapLoginButton()
            .assert(\.loginFailedAlertToast, equals: "Please check your credentials and try again")
    }


}
