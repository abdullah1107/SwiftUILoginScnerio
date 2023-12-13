//
//  ProductDashBoardTests.swift
//  AuthenticationSwiftUIUITests
//
//  Created by Muhammad Mamun on 10/12/23.
//

import XCTest

final class ProductDashBoardTests: BaseXCTestSetup {

    
    func testProductDashBoardDisPlay(){
        //mack()
        DashBoard.ProductScreen()
            .assertDisplayed(DashBoard.ProductScreen())
    }
    
    func testSearchItemForDisplay(){
        DashBoard.ProductScreen()
            .assertDisplayed(DashBoard.ProductScreen())
            .tapSearchField("iPhone")
            .assert(\.searchItemFound, equals: 2, "Item is not found as expected")
    }
    
    
    func testClickSearchElement(){
        DashBoard.ProductScreen()
            .tapSearchField("iPhone")
            .tapSearchElementItem()
            .assertDisplayed(ProductDetails.ProductElement())
    }

}
