//
//  LoginTests.swift
//  AuthenticationSwiftUITests
//
//  Created by Muhammad Mamun on 7/12/23.
//

import XCTest
import Combine
@testable import AuthenticationSwiftUI

final class LoginTests: XCTestCase {

    var loginViewModel: LoginViewModel!
    var cancellables: Set<AnyCancellable> = []
    
    override func setUpWithError() throws {
        super.setUp()
        loginViewModel = LoginViewModel()
    }

    override func tearDownWithError() throws {
        loginViewModel = nil
        cancellables.removeAll()
        super.tearDown()
    }
    
    
    func testUserNameNotValid(){
        loginViewModel.userName = "test"
        let getResult = loginViewModel.isUserNameValidPublisher
            .sink { result in
                XCTAssertFalse(result, "User name is valid")
            }
        getResult.cancel()
    }
    
    func testUserNameIsValid(){
        loginViewModel.userName = "kminchelle"
        let getResult = loginViewModel.isUserNameValidPublisher
            .sink { result in
                XCTAssertTrue(result, "User name is not valid")
            }
        getResult.cancel()
    }
    
    func testPasswordInvalid(){
        loginViewModel.password = "@34Ts"
        let getResult = loginViewModel.isPasswordValidPublisher
            .sink { result in
                XCTAssertFalse(result, "Password is valid")
            }
        getResult.cancel()
    }
    
    func testPasswordValidCheck(){
        loginViewModel.password = "0lelplR"
        let getResult = loginViewModel.isPasswordValidPublisher
            .sink { result in
                XCTAssertTrue(result, "Password is not valid")
            }
        getResult.cancel()
    }
    
    
    func testFormValidate(){
        loginViewModel.userName = "kminchelle"
        loginViewModel.password = "0lelplR"
        
        let getResult = loginViewModel.isSignInFormValidPublisher
            .sink { value in
               XCTAssertTrue(value, "Form is not valid")
            }
        getResult.cancel()
        
        loginViewModel.userName = ""
        loginViewModel.password = ""
        
        let getResultOutput = loginViewModel.isSignInFormValidPublisher
            .sink { value in
               XCTAssertFalse(value, "Form is valid")
            }
        getResultOutput.cancel()
    }
    
    
    func testSuccessUserLoginCheck(){
        
        let expectation = XCTestExpectation(description: "Authentication expectation")
        
        loginViewModel.creareNewUserStatus(username: "kminchelle", password: "0lelplR") { result in
            switch result {
            case .success(let isAuthenticated):
                XCTAssertTrue(isAuthenticated, "Authentication should succeed with valid credentials")
            case .failure:
                XCTFail("Unexpected failure")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
        
    }
    
    func testWrongUserLoginCheck(){
        let expectation = XCTestExpectation(description: "Authentication expectation")
        
        loginViewModel.creareNewUserStatus(username: "abdullah54", password: "0lelplR") { result in
            switch result {
            case .success:
                XCTFail("Authentication should fail with invalid credentials")
            case .failure(let error as LoginError):
                XCTAssertEqual(error, LoginError.networkError, "Error should be invalid credentials")
            case .failure:
                XCTFail("Unexpected failure")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }

}
