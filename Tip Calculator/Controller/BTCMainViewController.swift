//
//  BTCMainViewController.swift
//  Blue Tip Calculator
//
//  Created by Daniel Pratt on 11/3/17.
//  Copyright © 2017 blaumagier. All rights reserved.
//

import Foundation
import UIKit

class BTCMainViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var numberOfPeopleButton: UIButton!
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalWithTip: UILabel!
    @IBOutlet weak var tipAmountSegment: UISegmentedControl!
    
    // Hidden until split bill is tapped
    @IBOutlet weak var numPeopleLabel: UILabel!
    @IBOutlet weak var numPeopleSegment: UISegmentedControl!
    
    // MARK: - Objects
    
    // Tracks app opens to determine if app store review should be displayed or not
    let rateInAppStore = BTCAppStoreReview()
    
    // Holds bill and calculates tip and total amount
    var tipCalculator = BTCTipCalculator()
}
