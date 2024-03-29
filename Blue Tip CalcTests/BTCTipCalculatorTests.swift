//
//  BTCTipCalculatorTests.swift
//  Blue Tip CalcTests
//
//  Created by Daniel Pratt on 11/7/17.
//  Copyright © 2017 blaumagier. All rights reserved.
//

import XCTest
@testable import Blue_Tip_Calc

class BTCTipCalculatorTests: XCTestCase {
    
    var tipCalculator = BTCTipCalculator()
    var numberFormatter = NumberFormatter()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = 2
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSetNumPeopleSplitting_setAmountThree_isBillBeingSplitEqualsTrue() {
        tipCalculator.setNumPeopleSplitting(numPeople: 3)
        
        // make sure value was set properly
        XCTAssert(tipCalculator.numPeopleSplittingBill == 3)
       
        // make sure that bill is being split now
        XCTAssertTrue(tipCalculator.isBillBeingSplit)
    }
    
    func testSetNumPeopleSplitting_setAmountOne_isBillBeingSplitEqualsFalse() {
        tipCalculator.setNumPeopleSplitting(numPeople: 1)
        
        // make sure value was set properly
        XCTAssert(tipCalculator.numPeopleSplittingBill == 1)
        
        // make sure that bill is not being split now
        XCTAssertFalse(tipCalculator.isBillBeingSplit)
    }
    
    func testSetBillAmount_totalsCalculate() {
        tipCalculator.setBillAmount(billAmount: 10.99)
        // make sure that value was set properly
        XCTAssert(tipCalculator.billAmount == 10.99)
        
        // make sure that calculated tip is correct
        let tipAmountString = numberFormatter.string(from: tipCalculator.amountToTip as NSNumber)
        let tipAmount = Double(truncating: numberFormatter.number(from: tipAmountString!)!)
        XCTAssert(tipAmount == 1.65)
        
        // make sure that total bill is correct
        let totalBillString = numberFormatter.string(from: tipCalculator.totalBillWithTipAmount as NSNumber)
        let totalBill = Double(truncating: numberFormatter.number(from: totalBillString!)!)
        XCTAssertTrue(totalBill == 12.64)
    }
    
    func testSetTipAmount_totalsCalculate() {
        tipCalculator.setBillAmount(billAmount: 10.99)
        tipCalculator.setTipPercentValue(tipPercent: TipPercentValue(rawValue: 0.20)!)
        
        // make sure that calculated tip is correct
        let tipAmountString = numberFormatter.string(from: tipCalculator.amountToTip as NSNumber)
        let tipAmount = Double(truncating: numberFormatter.number(from: tipAmountString!)!)
        XCTAssert(tipAmount == 2.20)
        
        // make sure that total bill is correct
        let totalBillString = numberFormatter.string(from: tipCalculator.totalBillWithTipAmount as NSNumber)
        let totalBill = Double(truncating: numberFormatter.number(from: totalBillString!)!)
        XCTAssertTrue(totalBill == 13.19)
    }
    
    func testSplitBill_splitBy2_expectedAndActualMatch() {
        // setup
        tipCalculator.setBillAmount(billAmount: 10.00)
        tipCalculator.setTipPercentValue(tipPercent: TipPercentValue(rawValue: 0.10)!)
        tipCalculator.setNumPeopleSplitting(numPeople: 2)
        
        // get rounded number for tip amount
        let tipAmountString = numberFormatter.string(from: tipCalculator.amountToTip as NSNumber)
        let tipAmount = Double(truncating: numberFormatter.number(from: tipAmountString!)!)
        
        // get rounded number for total bil amount
        let totalBillString = numberFormatter.string(from: tipCalculator.totalBillWithTipAmount as NSNumber)
        let totalBill = Double(truncating: numberFormatter.number(from: totalBillString!)!)
        
        // make sure that calculated tip is correct
        XCTAssert(tipAmount == 0.50)
        
        // make sure that total bill is correct
        XCTAssertTrue(totalBill == 5.50)
    }
    
    func testSplitBill_splitBy3_expectedAndActualMatch() {
        // setup
        tipCalculator.setBillAmount(billAmount: 32.47)
        tipCalculator.setTipPercentValue(tipPercent: TipPercentValue(rawValue: 0.15)!)
        tipCalculator.setNumPeopleSplitting(numPeople: 3)
        
        // get rounded number for tip amount
        let tipAmountString = numberFormatter.string(from: tipCalculator.amountToTip as NSNumber)
        let tipAmount = Double(truncating: numberFormatter.number(from: tipAmountString!)!)
        
        // get rounded number for total bil amount
        let totalBillString = numberFormatter.string(from: tipCalculator.totalBillWithTipAmount as NSNumber)
        let totalBill = Double(truncating: numberFormatter.number(from: totalBillString!)!)
        
        // make sure that calculated tip is correct
        XCTAssert(tipAmount == 1.62)
        
        // make sure that total bill is correct
        XCTAssertTrue(totalBill == 12.45)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            testSetBillAmount_totalsCalculate()
        }
    }
    
}
