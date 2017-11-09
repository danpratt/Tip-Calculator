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
    
    // MARK: - Objects
    
    // Tracks app opens to determine if app store review should be displayed or not
    let rateInAppStore = BTCAppStoreReview()
    
    // Holds bill and calculates tip and total amount
    var tipCalculator = BTCTipCalculator()
    
    override func viewDidLoad() {
        // set button image to aspect fit
        self.numberOfPeopleButton.imageView?.contentMode = .scaleAspectFit
        
        // check to see if app store rating request should be made
        if rateInAppStore.shouldAskToRate {
            SKStoreReviewController.requestReview()
        }
        
        // Set the textfield delegate
        billTextField.delegate = self
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
        
        switch currentSegment {
        case 0:
            tipCalculator.setTipPercentValue(tipPercent: 0.10)
        case 1:
            tipCalculator.setTipPercentValue(tipPercent: 0.15)

        case 2:
            tipCalculator.setTipPercentValue(tipPercent: 0.18)

        case 3:
            tipCalculator.setTipPercentValue(tipPercent: 0.20)

        case 4:
            tipCalculator.setTipPercentValue(tipPercent: 0.25)

        default:
            tipCalculator.setTipPercentValue(tipPercent: 0.20)
        }
        calculateTip()
    }
    
    // Will control show or hide the split bill items
    @IBAction func splitBillButtonPressed(_ sender: UIButton) {
        if numPeopleLabel.isHidden {
            numPeopleLabel.isHidden = false
            numPeopleSegment.isEnabled = true
            numPeopleSegment.isHidden = false
            calculateTip()
        } else {
            numPeopleLabel.isHidden = true
            numPeopleSegment.isEnabled = false
            numPeopleSegment.isHidden = true
            tipCalculator.setNumPeopleSplitting(numPeople: 1)
            calculateTip()
        }
    }
    
    @IBAction func numPeopleSegmentChanged(_ sender: UISegmentedControl) {
        let numPeople = numPeopleSegment.selectedSegmentIndex + 1
        numPeopleSegment.resignFirstResponder()
        tipCalculator.setNumPeopleSplitting(numPeople: numPeople)
        calculateTip()
    }
    
    // MARK: - Calculate Tip
    
    func calculateTip() {
        guard let billText = billTextField.text else {
            fatalError("Error getting text from billTextField")
        }
        
        // check for empty string, and if there is nothing entered, do nothing
        if billText == "" {
            return
        }
        
        // setup the number formatter
        let numberFormatter = setupNumberFormatter()
        
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
    
    // MARK: - Number Formatter
    
    private func setupNumberFormatter() -> NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = 2
        //numberFormatter.locale = Locale(identifier: Locale.current.identifier)
        numberFormatter.numberStyle = .currency
        numberFormatter.isLenient = true
        
        return numberFormatter
    }
}


