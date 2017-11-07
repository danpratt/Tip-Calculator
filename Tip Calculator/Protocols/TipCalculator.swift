//
//  TipCalculator.swift
//  Blue Tip Calculator
//
//  Created by Daniel Pratt on 11/7/17.
//  Copyright © 2017 blaumagier. All rights reserved.
//

protocol TipCalculator {
    var tipPercentValue: Double { get set }
    var numPeopleSplittingBill: Int { get set }
    var isBillBeingSplit: Bool { get set }
    var billAmount: Double { get set }
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
    
    var totalBillWithTipAmount: Double {
        // returns the total for the bill
        let total = billAmount + amountToTip
        if !isBillBeingSplit {
            return total
        } else {
            return total / Double(numPeopleSplittingBill)
        }
    }
}
