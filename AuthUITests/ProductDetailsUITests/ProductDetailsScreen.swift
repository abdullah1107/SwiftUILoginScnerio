//
//  ProductDetailsScreen.swift
//  AuthUIUITests
//
//  Created by Muhammad Mamun on 11/12/23.
//

import Foundation
import XCTest


extension ProductDetails{
    struct ProductElement: Screen{
        var displayElement: XCUIElement { titleLabel }
        init() {
            waitForScreenDisplay()
        }
    }
}


extension ProductDetails.ProductElement{
    var titleLabel: XCUIElement { app.staticTexts["productDetailsIdentifier"].firstMatch }
}


