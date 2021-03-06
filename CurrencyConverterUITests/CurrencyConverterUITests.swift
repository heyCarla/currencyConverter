//
//  CurrencyConverterUITests.swift
//  CurrencyConverterUITests
//
//  Created by Carla Alexander on 2015-10-08.
//  Copyright © 2015 Carla. All rights reserved.
//

import XCTest

class CurrencyConverterUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAUDInputToForeignConversionOutputAmount(){
        
        let app = XCUIApplication()
        app.childrenMatchingType(.Window).elementBoundByIndex(0).childrenMatchingType(.Other).element.childrenMatchingType(.Other).elementBoundByIndex(1).childrenMatchingType(.TextField).element.typeText("12345")
        app.typeText("\r")
        
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery.staticTexts["CAD"].swipeLeft()
        collectionViewsQuery.staticTexts["EUR"].swipeLeft()
        collectionViewsQuery.staticTexts["GBP"].swipeLeft()
        collectionViewsQuery.staticTexts["JPY"].swipeLeft()
        
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}
