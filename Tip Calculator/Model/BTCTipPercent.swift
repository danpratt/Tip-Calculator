//
//  BTCTipPercent.swift
//  Blue Tip Calculator
//
//  Created by Daniel Pratt on 11/9/17.
//  Copyright © 2017 blaumagier. All rights reserved.
//

import Foundation

enum TipPercentValue: Double {
    case ten = 0.10, fifteen = 0.15, eighteen = 0.18, twenty = 0.20, twentyFive = 0.25
    
    static func fromHashValue(hashValue: Int) -> TipPercentValue {
        switch hashValue {
        case 0:
            return .ten
        case 1:
            return.fifteen
        case 2:
            return .eighteen
        case 3:
            return .twenty
        case 4:
            return .twentyFive
        default:
            return .fifteen
        }
    }
}
