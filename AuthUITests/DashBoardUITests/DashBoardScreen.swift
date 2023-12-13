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
    var searchBarTextField: XCUIElement { app.searchFields["Search Product"] }
    var searchingCells: XCUIElement { app.cells.element }
}


extension DashBoard.ProductScreen {
   
    var loginSuccessAlertToast: String {
        loginSuccessToast.waitUntilDisplayed()
        return loginSuccessToast.label
    }
    
    @discardableResult
    func tapSearchField(_ searchItem:String) -> Self {
        searchBarTextField.waitUntilDisplayed()
        searchBarTextField.tap()
        searchBarTextField.typeText(searchItem)
        return self
    }
    
    var searchItemFound: Int {
        searchingCells.waitUntilDisplayed()
        return searchingCells.buttons.count
    }
    
    @discardableResult
    func tapSearchElementItem() -> ProductDetails.ProductElement{
        searchingCells.waitUntilDisplayed()
        app.cells.element(boundBy: 0).tap()
        return ProductDetails.ProductElement()
    }
  
}
