//
//  BTCAppStoreReview.swift
//  Blue Tip Calculator
//
//  Created by Daniel Pratt on 11/6/17.
//  Copyright © 2017 blaumagier. All rights reserved.
//

import Foundation
import StoreKit

struct BTCAppStoreReview: RateInAppStore {
    
    var timesUserHasOpenedApp: Int? = UserDefaults.standard.integer(forKey: "timesUserHasOpenedApp_")
    var doNotBugToRate: Bool? = UserDefaults.standard.bool(forKey: "doNotBugToRate_")
    let openTimesToCheck: Int = 4
    
    mutating func updateTimesUserHasOpenedApp() {
        if timesUserHasOpenedApp == nil || doNotBugToRate == nil {
            timesUserHasOpenedApp = 1
            doNotBugToRate = false
            setNotToBugUser()
        } else if !doNotBugToRate! {
            timesUserHasOpenedApp = timesUserHasOpenedApp! + 1
            setTimesUserHasOpenedApp()
        }
    }
    
    func setTimesUserHasOpenedApp() {
        UserDefaults.standard.set(timesUserHasOpenedApp, forKey: "timesUserHasOpenedApp_")
    }
    
    func setNotToBugUser() {
        UserDefaults.standard.set(doNotBugToRate, forKey: "doNotBugToRate_")
    }
    
}
