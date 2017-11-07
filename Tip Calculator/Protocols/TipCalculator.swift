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
        return billAmount * tipPercentValue
    }
    
    var totalBillWithTipAmount: Double {
        return billAmount + amountToTip
    }
}
