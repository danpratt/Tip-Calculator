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
    // holds app open count information
    let appStoreReview = BTCAppStoreReview()
    
    @IBOutlet weak var numberOfPeopleButton: UIButton!
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalWithTip: UILabel!
    @IBOutlet weak var tipAmountSegment: UISegmentedControl!
    
    // Hidden until split bill is tapped
    
    @IBOutlet weak var numPeopleLabel: UILabel!
    
    var tipValue: Double = 0.15
    var numPeopleToSplit: Int = 1
    var isSplittingBill: Bool = false
    @IBOutlet weak var numPeopleSegment: UISegmentedControl!
}
