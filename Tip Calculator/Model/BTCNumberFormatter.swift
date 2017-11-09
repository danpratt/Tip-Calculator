//
//  BTCNumberFormatter.swift
//  Blue Tip Calculator
//
//  Created by Daniel Pratt on 11/9/17.
//  Copyright © 2017 blaumagier. All rights reserved.
//

import Foundation

struct BTCNumberFormatter {
    let numberFormatter = NumberFormatter()
    
    init() {
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.locale = Locale(identifier: Locale.current.identifier)
        numberFormatter.numberStyle = .currency
        numberFormatter.isLenient = true
    }
    
}
