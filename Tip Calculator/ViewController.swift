//
//  ViewController.swift
//  Tip Calculator
//
//  Created by Daniel Pratt on 8/4/15.
//  Copyright © 2015 blaumagier. All rights reserved.
//

import Foundation
import UIKit
import StoreKit

var timesUserHasOpenedApp : Int?
var doNotBugToRate : Bool?

class ViewController: UIViewController, SKStoreProductViewControllerDelegate {
    
    // Properties for offering store information
    let openTimesToCheck = 2
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.numberOfPeopleButton.imageView?.contentMode = .scaleAspectFit
        updateTimesUserHasOpenedApp()
        print("The currency here is \(String(describing: Locale.current.currencySymbol)))")
    }

    /* Called when convert button is tapped */
    @IBAction func convertButtonTapped(_ sender: UIButton) {
        billTextField.resignFirstResponder()
        calculateTip()
        
        // Check to see if user has opened the app three times already if so, call the rate app popup
        if timesUserHasOpenedApp! >= openTimesToCheck && !doNotBugToRate! {
            showRateUsAlert(Alerts.RateUsTitle, message: Alerts.RateUsMessage)
            timesUserHasOpenedApp = 0
            setTimesUserHasOpenedApp()
        }
        
    }
    
    @IBAction func tipAmountSegmentValueChanged(_ sender: UISegmentedControl) {
        let currentSegment = tipAmountSegment.selectedSegmentIndex
        tipAmountSegment.resignFirstResponder()
        billTextField.resignFirstResponder() // in case keyboard is still open, close it
        
        switch currentSegment {
        case 0:
            tipValue = 0.10
        case 1:
            tipValue = 0.15
        case 2:
            tipValue = 0.18
        case 3:
            tipValue = 0.20
        case 4:
            tipValue = 0.25
        default:
            tipValue = 0.20
        }
        
        calculateTip()
    }
    
    @IBAction func numPeopleSegmentChanged(_ sender: UISegmentedControl) {
        updateNumPeople()
        print("Number of people to split = \(String(describing: numPeopleToSplit))")
        calculateTip()
    }
    
    
    /* Calculate the tip here */
    
    func calculateTip() {
        guard let billText = billTextField.text else {
            print("Error getting text")
            return
        } // get value from textfield
        
        let numberFormatter = setupNumberFormatter()
        
        let totalOfBillBeoreTip : Double = Double(((numberFormatter.number(from: billText)))!)
        
        print("Bill is \(String(describing: totalOfBillBeoreTip))")
        
        // calculate the tip amount and the total amount to pay
        var tipToPay : Double = tipValue * totalOfBillBeoreTip // cost of tip
        var totalAmountToPay : Double = tipToPay + totalOfBillBeoreTip
        
        // split these numbers up if the bill is being split
        if !numPeopleSegment.isHidden {
            tipToPay /= Double(numPeopleToSplit)
            totalAmountToPay /= Double(numPeopleToSplit)
        }
        
        // Setup labels
        tipLabel.text = numberFormatter.string(from: tipToPay as NSNumber)
        totalWithTip.text = numberFormatter.string(from: totalAmountToPay as NSNumber)
        
        // Display labels if they are hidden
        // Only need to check one of the labels because if one is hidden, they are both hidden
        if tipLabel.isHidden {
            tipLabel.isHidden = false
            totalWithTip.isHidden = false
        }
    }
    
    @IBAction func splitBillButtonPressed(_ sender: UIButton) {
        if numPeopleLabel.isHidden {
            numPeopleLabel.isHidden = false
            numPeopleSegment.isEnabled = true
            numPeopleSegment.isHidden = false
            isSplittingBill = true
            updateNumPeople()
            calculateTip()
        } else {
            numPeopleLabel.isHidden = true
            numPeopleSegment.isEnabled = false
            numPeopleSegment.isHidden = true
            numPeopleToSplit = 1
            isSplittingBill = false
            calculateTip()
        }
    }

    func updateNumPeople() {
        let currentSegment = numPeopleSegment.selectedSegmentIndex
        numPeopleSegment.resignFirstResponder()
        billTextField.resignFirstResponder() // in case keyboard is still open, close it
        
        switch currentSegment {
        case 0:
            numPeopleToSplit = 1
        case 1:
            numPeopleToSplit = 2
        case 2:
            numPeopleToSplit = 3
        case 3:
            numPeopleToSplit = 4
        case 4:
            numPeopleToSplit = 5
        case 5:
            numPeopleToSplit = 6
        default:
            numPeopleToSplit = 1
        }
    }
    
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

