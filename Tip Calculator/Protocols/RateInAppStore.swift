//
//  RateInAppStore.swift
//  Blue Tip Calculator
//
//  Created by Daniel Pratt on 11/3/17.
//  Copyright © 2017 blaumagier. All rights reserved.
//

protocol RateInAppStore {
    var timesUserHasOpenedApp : Int? { get set }
    var doNotBugToRate : Bool? { get set }
    var openTimesToCheck : Int { get }
    var shouldAskToRate : Bool { get }
}

extension RateInAppStore {
    var shouldAskToRate : Bool {
        return timesUserHasOpenedApp == openTimesToCheck
    }
}
