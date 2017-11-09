//
//  TipCalculator.swift
//  Blue Tip Calculator
//
//  Created by Daniel Pratt on 11/7/17.
//  Copyright © 2017 blaumagier. All rights reserved.
//

protocol TipCalculator {
    var tipPercentValue: Double { get }
    var numPeopleSplittingBill: Int { get }
    var isBillBeingSplit: Bool { get }
    var billAmount: Double { get }
    var amountToTip: Double { get }
    var totalBillWithTipAmount: Double { get }
}

extension TipCalculator {
    // returns the total for the tip
    var amountToTip: Double {
        let total = billAmount * tipPercentValue
        if !isBillBeingSplit {
            return total
        } else {
            return total / Double(numPeopleSplittingBill)
        }
        
    }
    
    // returns the total for the bill including tip
    var totalBillWithTipAmount: Double {
        let total = billAmount + amountToTip
        if !isBillBeingSplit {
            return total
        } else {
            return (billAmount / Double(numPeopleSplittingBill)) + amountToTip
        }
    }
    
    // returns a bool saying if tip is being split or not
    var isBillBeingSplit: Bool {
        return numPeopleSplittingBill > 1
    }
}
