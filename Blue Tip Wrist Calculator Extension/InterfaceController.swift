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
    
    var display = 0.0
    var total = 0.0
    var tipTotal = 0.0
    var totalWithTip = 0.0
    var lastNumber = [0.00]
    
    // formatting
    let format = NumberFormatter()
    
    @IBOutlet var totalLabel: WKInterfaceLabel!
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.

    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
//        format.maximumFractionDigits = 2
//        format.minimumFractionDigits = 2
//        format.minimumIntegerDigits = 1
        format.numberStyle = NumberFormatter.Style.currency
        
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    // Error message to display
    func presentError() {
        self.presentAlert(withTitle: "Enter Total", message: "Please enter bill total before calculating tip", preferredStyle: WKAlertControllerStyle.alert, actions: [WKAlertAction.init(title: "OK", style: WKAlertActionStyle.default, handler: {})])
    }
    
    // When backspace is pressed, remove last number
    func backPressed() {
//        print("← pressed")
        if lastNumber.count > 2 {
            total -= lastNumber.popLast()!
            total /= 10
            print(total)
            print(lastNumber.count)
            updateLabel()
        } else  if lastNumber.count == 2 {
            total = 0.00
            updateLabel()
        }

    }
    
    func zeroPressed() {
//        print("0 pressed")
        total *= 10
        lastNumber.append(0.00)
        total += lastNumber.last!
        updateLabel()
    }
    
    // Calculate total will call other function
    // because menu option will also exist
    func calculatePressed() {
//        print("Calc pressed")
        calculateTip()
    }
    
    func onePressed() {
//        print("1 pressed")
        total *= 10
        lastNumber.append(0.01)
        total += lastNumber.last!
        updateLabel()
    }
    
    func twoPressed() {
//        print("2 pressed")
        total *= 10
        lastNumber.append(0.02)
        total += lastNumber.last!
        updateLabel()
    }
    
    func threePressed() {
//        print("3 pressed")
        total *= 10
        lastNumber.append(0.03)
        total += lastNumber.last!
        updateLabel()
    }
    
    func fourPressed() {
//        print("4 pressed")
        total *= 10
        lastNumber.append(0.04)
        total += lastNumber.last!
        updateLabel()
    }
    
    func fivePressed() {
//        print("5 pressed")
        total *= 10
        lastNumber.append(0.05)
        total += lastNumber.last!
        updateLabel()
    }
    
    func sixPressed() {
//        print("6 pressed")
        total *= 10
        lastNumber.append(0.06)
        total += lastNumber.last!
        updateLabel()
    }
    
    func sevenPressed() {
//        print("7 pressed")
        total *= 10
        lastNumber.append(0.07)
        total += lastNumber.last!
        updateLabel()
    }
    
    func eightPressed() {
//        print("8 pressed")
        total *= 10
        lastNumber.append(0.08)
        total += lastNumber.last!
        updateLabel()
    }
    
    func ninePressed() {
//        print("9 pressed")
        total *= 10
        lastNumber.append(0.09)
        total += lastNumber.last!
        updateLabel()
    }
    
    func updateLabel() {
        totalLabel.setText("Bill amount: " + format.string(from: NSNumber(floatLiteral: total))!)

        
    }
    
    func calculateTip() {
        if lastNumber.count > 1 && total > 0.0 {
            tipTotal = (total * SharedData.sharedInstance.tipPercent) / Double(SharedData.sharedInstance.numPeople)
            totalWithTip = total + tipTotal
            totalLabel.setText("Tip: " + format.string(from: NSNumber(floatLiteral: tipTotal))!)
        } else {
            presentError()
        }
    }
    
    
    @IBAction func showTotalWithTipMenuPressed() {
        if tipTotal > 0.0 {
            totalLabel.setText("Total+tip: " + format.string(from: NSNumber(floatLiteral: totalWithTip))!)
        } else if total > 0.0 {
            calculateTip()
            totalLabel.setText("Total+tip: " + format.string(from: NSNumber(floatLiteral: totalWithTip))!)
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
        display = 0.0
        total = 0.0
        tipTotal = 0.0
        totalWithTip = 0.0
        lastNumber = [0.00]
        updateLabel()
    }
    
    
}

class SharedData {
    var numPeople = 1
    var tipPercent = 0.15
    
    class var sharedInstance: SharedData {
        struct CalcData {
            static let instance = SharedData()
        }
        return CalcData.instance
    }
}
