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

    
    func testLoginWithvalidCredentials() {
        Login.LoginScreen()
            .tapUserTextField("kminchelle")
            .tapPasswordTextField("0lelplR")
            .tapLoginButtonSuccess()
            .assertDisplayed(DashBoard.ProductScreen())
    }

}


//0  0  0 = 6
//1  1  1 = 6
//2 + 2 + 2 = 6
//3 * 3 - 3 = 6
// sqrt(4)+sqrt(4)+sqrt(4)  = 6
//(5-5)! +  5 = 6
// 7 7 7
