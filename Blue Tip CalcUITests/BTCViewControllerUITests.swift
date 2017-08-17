//
//  BTCViewControllerUITests.swift
//  Blue Tip Calculator
//
//  Created by Daniel Pratt on 8/17/17.
//  Copyright © 2017 blaumagier. All rights reserved.
//

import XCTest
@testable import Blue_Tip_Calc

class BTCViewControllerUITests: XCTestCase {
    
    let sut = ViewController()
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    func test_calculateTip_noSplit() {
        sut.billTextField.text =  "$35.79"
        sut.numPeopleSegment.isHidden = true
        
        let expectedTotal = "$41.16"
        let expectedTip = "$5.37"
        
        sut.calculateTip()
        
        XCTAssertEqual(sut.tipLabel.text, expectedTip)
        XCTAssertEqual(sut.totalWithTip.text, expectedTotal)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}
