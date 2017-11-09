//
//  BTCTipCalculator.swift
//  Blue Tip Calculator
//
//  Created by Daniel Pratt on 11/7/17.
//  Copyright © 2017 blaumagier. All rights reserved.
//

import Foundation

class BTCTipCalculator: TipCalculator {
    var tipPercentValue: TipPercentValue = .fifteen
    var numPeopleSplittingBill: Int = 1
    var billAmount: Double = 0.0
    
    /// This should be set from interface, entered by the user and represents the final amount of their bill.  This should be entered in a 000.00 format (two decmial places) and is the amount used for calculating tip, and total bill.
    /// ----
    ///
    /// Example Usage:
    ///
    ///     // Create a tip calculator object
    ///     let tipCalculator = BTCTipCalculator()
    ///     tipCalculator.setBillAmount(billAmount: 10.99)
    ///
    ///
    /// - parameters:
    ///   - billAmount: (Double) The input value from user representing the pre-tip bill the user must pay.
    func setBillAmount(billAmount: Double) {
        self.billAmount = billAmount
    }
    
    /// This value should be set by user and is an Int representation of the number of people splitting a bill.
    /// ----
    ///
    /// Example Usage:
    ///
    ///     // Create a tip calculator object
    ///     let tipCalculator = BTCTipCalculator()
    ///     setNumPeopleSplitting(numPeople: 3)
    ///
    ///
    /// - parameters:
    ///   - numPeople: (Int) The number of people splitting a bill.
    func setNumPeopleSplitting(numPeople: Int) {
        self.numPeopleSplittingBill = numPeople
    }
    
    /// This value should be set by user and represents the percentage of the tip as a double.
    /// The proper format should be in decimal where 1 = 100%.  For a 15% tip, this would be represented as 0.15.
    /// ----
    ///
    /// Example Usage:
    ///
    ///     // Create a tip calculator object
    ///     let tipCalculator = BTCTipCalculator()
    ///     setTipPercentValue(tipPercent: 0.15)
    ///
    ///
    /// - parameters:
    ///   - tipPercent: (Double) The decmial value of a tip.
    func setTipPercentValue(tipPercent: TipPercentValue) {
        self.tipPercentValue = tipPercent
    }
    
    class var sharedInstance : BTCTipCalculator {
        struct CalcData {
            static let instance = BTCTipCalculator()
        }
        return CalcData.instance
    }
    
}
