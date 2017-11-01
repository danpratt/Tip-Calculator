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
    var format: NumberFormatter!
    
    @IBOutlet var totalLabel: WKInterfaceLabel!
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.

    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        format = setupNumberFormatter()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    // Error message to display
    func presentError() {
        let errorTitle = getLocalizedErrorTitle()
        let errorMessage = getLocalizedErrorMessage()
        self.presentAlert(withTitle: errorTitle, message: errorMessage, preferredStyle: WKAlertControllerStyle.alert, actions: [WKAlertAction.init(title: "OK", style: WKAlertActionStyle.default, handler: {})])
    }
    
    // When backspace is pressed, remove last number
    @IBAction func backSpacePressed() {
        print("← pressed")
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
    
    @IBAction func zeroPressed() {
//        print("0 pressed")
        total *= 10
        lastNumber.append(0.00)
        total += lastNumber.last!
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
        total *= 10
        lastNumber.append(0.01)
        total += lastNumber.last!
        updateLabel()
    }
    
    @IBAction func twoPressed() {
//        print("2 pressed")
        total *= 10
        lastNumber.append(0.02)
        total += lastNumber.last!
        updateLabel()
    }
    
    @IBAction func threePressed() {
//        print("3 pressed")
        total *= 10
        lastNumber.append(0.03)
        total += lastNumber.last!
        updateLabel()
    }
    
    @IBAction func fourPressed() {
//        print("4 pressed")
        total *= 10
        lastNumber.append(0.04)
        total += lastNumber.last!
        updateLabel()
    }
    
    @IBAction func fivePressed() {
//        print("5 pressed")
        total *= 10
        lastNumber.append(0.05)
        total += lastNumber.last!
        updateLabel()
    }
    
    @IBAction func sixPressed() {
//        print("6 pressed")
        total *= 10
        lastNumber.append(0.06)
        total += lastNumber.last!
        updateLabel()
    }
    
    @IBAction func sevenPressed() {
//        print("7 pressed")
        total *= 10
        lastNumber.append(0.07)
        total += lastNumber.last!
        updateLabel()
    }
    
    @IBAction func eightPressed() {
//        print("8 pressed")
        total *= 10
        lastNumber.append(0.08)
        total += lastNumber.last!
        updateLabel()
    }
    
    @IBAction func ninePressed() {
//        print("9 pressed")
        total *= 10
        lastNumber.append(0.09)
        total += lastNumber.last!
        updateLabel()
    }
    
    @IBAction func updateLabel() {
        totalLabel.setText("\(billAmountString())" + format.string(from: NSNumber(floatLiteral: total))!)
    }
    
    @IBAction func calculateTip() {
        if lastNumber.count > 1 && total > 0.0 {
            tipTotal = (total * SharedData.sharedInstance.tipPercent) / Double(SharedData.sharedInstance.numPeople)
            totalWithTip = total + tipTotal
            totalLabel.setText("\(tipString())" + format.string(from: NSNumber(floatLiteral: tipTotal))!)
        } else {
            presentError()
        }
    }
    
    
    @IBAction func showTotalWithTipMenuPressed() {
        if tipTotal > 0.0 {
            totalLabel.setText("\(totalPlusTipString())" + format.string(from: NSNumber(floatLiteral: totalWithTip))!)
        } else if total > 0.0 {
            calculateTip()
            totalLabel.setText("\(totalPlusTipString())" + format.string(from: NSNumber(floatLiteral: totalWithTip))!)
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
    
    // MARK: - Private Helper Functions
    
    private func setupNumberFormatter() -> NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.locale = Locale(identifier: Locale.current.identifier)
        numberFormatter.numberStyle = .currency
        numberFormatter.isLenient = true
        
        return numberFormatter
    }
    
    // Localize error title
    func getLocalizedErrorTitle() -> String {
        let localeID = Locale.current.identifier
        switch localeID {
        case "nl_NL":
            return "Voer Totaal in"
        case "zh_Hans":
            return "输入总计"
        case "de":
            return "Gesamtsumme eingeben"
        default:
            return "Enter Total"
        }
    }
    
    // Localize error message
    func getLocalizedErrorMessage() -> String {
        let localeID = Locale.current.identifier
        switch localeID {
        case "nl_NL":
            return "Voer alstublieft de rekening totaal in voordat u de tip berekent"
        case "zh_Hans":
            return "计算提示前请输入帐单"
        case "de":
            return "Bitte rechnen Sie die Summe ein, bevor Sie den Tipp berechnen"
        default:
            return "Please enter bill total before calculating tip"
        }
    }
    
    // Localization variables
    func billAmountString() -> String {
        let localeID = Locale.current.identifier
        print("Locale ID is: \(localeID)")
        print("Loale is: \(Locale.current)")
        switch localeID {
        case "nl_NL":
            return "Rekening: "
        case "zh_Hans":
            return "帐单金额："
        case "de":
            return "Rechnung: "
        default:
            return "Bill total: "
        }
    }
    
    func tipString() -> String {
        let localeID = Locale.current.identifier
        switch localeID {
        case "nl_NL":
            return "Fooi: "
        case "zh_Hans":
            return "赏钱："
        case "de":
            return "Trinkgeld: "
        default:
            return "Tip: "
        }
    }
    
    func totalPlusTipString() -> String {
        let localeID = Locale.current.identifier
        switch localeID {
        case "nl_NL":
            return "Totaal+Fooi: "
        case "zh_Hans":
            return "总+小费："
        case "de":
            return "Total+Trinkgeld: "
        default:
            return "Total+Tip: "
        }
    }
}


// MARK: - Shared Data Singleton
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
