//
//  BTCMainViewController.swift
//  Blue Tip Calculator
//
//  Created by Daniel Pratt on 11/3/17.
//  Copyright © 2017 blaumagier. All rights reserved.
//

import Foundation
import UIKit
import StoreKit

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
    
    // Outlets for Constraints
    @IBOutlet weak var splitBillButtonCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var splitBillButtonTrailingConstraint: NSLayoutConstraint!
    
    // MARK: - Objects
    
    // Tracks app opens to determine if app store review should be displayed or not
    let rateInAppStore = BTCAppStoreReview()
    
    // Holds bill and calculates tip and total amount
    var tipCalculator = BTCTipCalculator()
    
    // MARK: - Properties
    
    // Tracks to see if textfield has been used
    var hasTextFieldBeenUsed = false
    
    override func viewDidLoad() {
        // set button image to aspect fit
        self.numberOfPeopleButton.imageView?.contentMode = .scaleAspectFit
        
        // check to see if app store rating request should be made
        if rateInAppStore.shouldAskToRate {
            SKStoreReviewController.requestReview()
        }
        
        // Set the textfield delegate
        billTextField.delegate = self
        billTextField.addTarget(self, action: #selector(billTextFieldDidChange), for: .editingChanged)
        billTextField.addDoneButtonToKeyboard(myAction: #selector(billTextField.resignFirstResponder))
    }
    
    // MARK: - Button Actions
    /* Called when convert button is tapped */
    @IBAction func convertButtonTapped(_ sender: UIButton) {
        billTextField.resignFirstResponder()
        calculateTip()
    }
    
    @IBAction func tipAmountSegmentValueChanged(_ sender: UISegmentedControl) {
        let currentSegment = tipAmountSegment.selectedSegmentIndex
        tipAmountSegment.resignFirstResponder()
        billTextField.resignFirstResponder() // in case keyboard is still open, close it
        
        tipCalculator.setTipPercentValue(tipPercent: TipPercentValue.fromHashValue(hashValue: currentSegment))
        calculateTip()
    }
    
    // Will control show or hide the split bill items
    @IBAction func splitBillButtonPressed(_ sender: UIButton) {
        
        // set constraint priorities so everything is displayed properly
        splitBillButtonTrailingConstraint.priority = numPeopleLabel.isHidden == true ? .defaultHigh : .defaultLow
        splitBillButtonCenterConstraint.priority = numPeopleLabel.isHidden == true ? .defaultLow : .defaultHigh
        
        // set labels to show or hide
        
        numPeopleLabel.isHidden = numPeopleLabel.isHidden == true ? false : true
        numPeopleSegment.isEnabled = numPeopleSegment.isEnabled == true ? false : true
        numPeopleSegment.isHidden = numPeopleSegment.isHidden == true ? false : true
        
        // set number of people
        let people = numPeopleSegment.isHidden == true ? 1 : numPeopleSegment.selectedSegmentIndex + 1
        tipCalculator.setNumPeopleSplitting(numPeople: people)
        
        // calculate the tip
        calculateTip()
    }
    
    @IBAction func numPeopleSegmentChanged(_ sender: UISegmentedControl) {
        let numPeople = numPeopleSegment.selectedSegmentIndex + 1
        numPeopleSegment.resignFirstResponder()
        tipCalculator.setNumPeopleSplitting(numPeople: numPeople)
        calculateTip()
    }
    
    // MARK: - Calculate Tip
    
    func calculateTip() {
        guard var billText = billTextField.text else {
            fatalError("Error getting text from billTextField")
        }
        
        // check for empty string, and if there is nothing entered, do nothing
        if !hasTextFieldBeenUsed {
            return
        } else if billText == "" {
            billText = "0"
        }
        
        // setup the number formatter
        let numberFormatter = BTCNumberFormatter().numberFormatter
        
        // get a double value for the bill (keyboard delegate has prevented anything but numbers from being entered)
        let billTotal : Double = Double(truncating: ((numberFormatter.number(from: billText)))!)
        
        // set the bill amount into our tipCalculator struct
        tipCalculator.setBillAmount(billAmount: billTotal)
        
        // MARK: - Update UI
        
        // Set Tip Label
        tipLabel.text = numberFormatter.string(from: tipCalculator.amountToTip as NSNumber)
        
        // Set total with tip label
        totalWithTip.text = numberFormatter.string(from: tipCalculator.totalBillWithTipAmount as NSNumber)
        
        // Display labels if they are hidden
        // Only need to check one of the labels because if one is hidden, they are both hidden
        if tipLabel.isHidden {
            tipLabel.isHidden = false
            totalWithTip.isHidden = false
        }
    }
    
    @objc private func billTextFieldDidChange() {
        hasTextFieldBeenUsed = true
        calculateTip()
    }
}


