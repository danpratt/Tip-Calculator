//
//  InterfaceController.swift
//  Blue Tip Wrist Calculator Extension
//
//  Created by Daniel Pratt on 11/18/15.
//  Copyright © 2015 blaumagier. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {
    
    var lastNumber = [0.00]
    var localeLanguageID: String = "en"
    
    // formatting
    var format: NumberFormatter!
    
    // Holds bill and calculates tip and total amount
    var tipCalculator = BTCTipCalculator.sharedInstance
    
    @IBOutlet var totalLabel: WKInterfaceLabel!
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        if let language = Locale.current.languageCode {
            localeLanguageID = language
        }
        
        format = BTCNumberFormatter().numberFormatter
        
        if lastNumber.count > 1 && tipCalculator.billAmount > 0.0 {
            updateAmountToTipDisplay()
        }
        
    }
    
    // Error message to display
    func presentError() {
        let errorTitle = getLocalizedErrorTitle()
        let errorMessage = getLocalizedErrorMessage()
        self.presentAlert(withTitle: errorTitle, message: errorMessage, preferredStyle: WKAlertControllerStyle.alert, actions: [WKAlertAction.init(title: "OK", style: WKAlertActionStyle.default, handler: {})])
    }
    
    // When backspace is pressed, remove last number
    @IBAction func backSpacePressed() {
//        print("← pressed")
        if lastNumber.count > 2 {
            tipCalculator.billAmount -= lastNumber.popLast()!
            tipCalculator.billAmount /= 10
            updateLabel()
        } else  if lastNumber.count == 2 {
            tipCalculator.billAmount = 0.00
            updateLabel()
        }
    }
    
    @IBAction func zeroPressed() {
//        print("0 pressed")
        tipCalculator.billAmount *= 10
        lastNumber.append(0.00)
        tipCalculator.billAmount += lastNumber.last!
        updateLabel()
    }
    
    // Calculate total will call other function
    // because menu option will also exist
    @IBAction func calculatePressed() {
//        print("Calc pressed")
        calculateTip()
    }
    
    @IBAction func onePressed() {
//        print("1 pressed")
        tipCalculator.billAmount *= 10
        lastNumber.append(0.01)
        tipCalculator.billAmount += lastNumber.last!
        updateLabel()
    }
    
    @IBAction func twoPressed() {
//        print("2 pressed")
        tipCalculator.billAmount *= 10
        lastNumber.append(0.02)
        tipCalculator.billAmount += lastNumber.last!
        updateLabel()
    }
    
    @IBAction func threePressed() {
//        print("3 pressed")
        tipCalculator.billAmount *= 10
        lastNumber.append(0.03)
        tipCalculator.billAmount += lastNumber.last!
        updateLabel()
    }
    
    @IBAction func fourPressed() {
//        print("4 pressed")
        tipCalculator.billAmount *= 10
        lastNumber.append(0.04)
        tipCalculator.billAmount += lastNumber.last!
        updateLabel()
    }
    
    @IBAction func fivePressed() {
//        print("5 pressed")
        tipCalculator.billAmount *= 10
        lastNumber.append(0.05)
        tipCalculator.billAmount += lastNumber.last!
        updateLabel()
    }
    
    @IBAction func sixPressed() {
//        print("6 pressed")
        tipCalculator.billAmount *= 10
        lastNumber.append(0.06)
        tipCalculator.billAmount += lastNumber.last!
        updateLabel()
    }
    
    @IBAction func sevenPressed() {
//        print("7 pressed")
        tipCalculator.billAmount *= 10
        lastNumber.append(0.07)
        tipCalculator.billAmount += lastNumber.last!
        updateLabel()
    }
    
    @IBAction func eightPressed() {
//        print("8 pressed")
        tipCalculator.billAmount *= 10
        lastNumber.append(0.08)
        tipCalculator.billAmount += lastNumber.last!
        updateLabel()
    }
    
    @IBAction func ninePressed() {
//        print("9 pressed")
        tipCalculator.billAmount *= 10
        lastNumber.append(0.09)
        tipCalculator.billAmount += lastNumber.last!
        updateLabel()
    }
    
    @IBAction func updateLabel() {
        totalLabel.setText("\(billAmountString())" + format.string(from: NSNumber(floatLiteral: tipCalculator.billAmount))!)
    }
    
    @IBAction func calculateTip() {
        if lastNumber.count > 1 && tipCalculator.billAmount > 0.0 {
            updateAmountToTipDisplay()
        } else {
            presentError()
        }
    }
    
    
    @IBAction func showTotalWithTipMenuPressed() {
        if tipCalculator.amountToTip > 0.0 {
            totalLabel.setText("\(totalPlusTipString())" + format.string(from: NSNumber(floatLiteral: tipCalculator.totalBillWithTipAmount))!)
        } else if tipCalculator.billAmount > 0.0 {
            calculateTip()
            totalLabel.setText("\(totalPlusTipString())" + format.string(from: NSNumber(floatLiteral: tipCalculator.totalBillWithTipAmount))!)
        } else {
            presentError()
        }
    }
    
    @IBAction func showTotalWithoutTipMenuPressed() {
        updateLabel()
    }
    
    @IBAction func showTipMenuPressed() {
        calculateTip()
    }
    
    
    @IBAction func clearEverythingMenuPressed() {
        tipCalculator.billAmount = 0.0
        lastNumber = [0.00]
        updateLabel()
    }
    
    // MARK: - Private Helper Functions
    
    // update tip display
    private func updateAmountToTipDisplay() {
        totalLabel.setText("\(tipString())" + format.string(from: NSNumber(floatLiteral: tipCalculator.amountToTip))!)
    }
}
