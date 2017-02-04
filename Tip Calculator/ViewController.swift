//
//  ViewController.swift
//  Tip Calculator
//
//  Created by Daniel Pratt on 8/4/15.
//  Copyright © 2015 blaumagier. All rights reserved.
//

import UIKit
import StoreKit

var timesUserHasOpenedApp : Int?

class ViewController: UIViewController, SKStoreProductViewControllerDelegate {
    
    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalWithTip: UILabel!
    @IBOutlet weak var tipAmountSegment: UISegmentedControl!
    
    // This view is hidden unless user has used app in cycles of 3 times
    @IBOutlet weak var rateUsView: UIView!
    
    // Hidden until split bill is tapped
    
    @IBOutlet weak var numPeopleLabel: UILabel!
    
    var tipValue: Double? = 0.15
    var numPeopleToSPlit: Int?
    var isSplittingBill: Bool = false
    @IBOutlet weak var numPeopleSegment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

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
        print("Number of people to split = \(numPeopleToSPlit)")
        calculateTip()
    }
    
    
    /* Calculate the tip here */
    
    func calculateTip() {
        let bill = Double(billTextField.text!)  // get value from textfield
        
        let format = NumberFormatter()
        format.maximumFractionDigits = 2
        format.minimumFractionDigits = 2
        
        if let unwrappedTotal = bill {
            if let tipValueToUse = tipValue  {
                var tipToPay = tipValueToUse * unwrappedTotal
                var amountToPay = unwrappedTotal + tipToPay
                if numPeopleSegment.isHidden == false {
                    tipToPay /= Double(numPeopleToSPlit!)
                    amountToPay /= Double(numPeopleToSPlit!)
                }
                tipLabel.text = format.string(from: NSNumber(floatLiteral: tipToPay))!
                totalWithTip.text = "$" +
                    format.string(from: NSNumber(floatLiteral: amountToPay))!  //"\(amountToPay)"
            }
            else {
                tipLabel.text = "Tip is nil"
                totalWithTip.text = "\(unwrappedTotal)"
            }
        }
        else {
            print("Optional was nil!")
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
            numPeopleToSPlit = 1
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
            numPeopleToSPlit = 1
        case 1:
            numPeopleToSPlit = 2
        case 2:
            numPeopleToSPlit = 3
        case 3:
            numPeopleToSPlit = 4
        case 4:
            numPeopleToSPlit = 5
        case 5:
            numPeopleToSPlit = 6
        default:
            numPeopleToSPlit = 1
        }
    }
    
    // Load user default with how many times user has opened the app
    
    func updateTimesUserHasOpenedApp() {
        timesUserHasOpenedApp = UserDefaults.standard.integer(forKey: "timesUserHasOpenedApp_")
        if timesUserHasOpenedApp == nil {
            timesUserHasOpenedApp = 1
        } else {
            timesUserHasOpenedApp = timesUserHasOpenedApp! + 1
            setTimesUserHasOpenedApp()
        }
        
        // Check to see if user has opened the app three times already if so, call the rate app popup
        if timesUserHasOpenedApp == 3 {
            timesUserHasOpenedApp = 0
            setTimesUserHasOpenedApp()
        }
    }
    
    func setTimesUserHasOpenedApp() {
        UserDefaults.standard.set(timesUserHasOpenedApp, forKey: "timesUserHasOpenedApp_")
    }
    
    func goToAppInAppStore() {
        print("opening appstore")
        let appId = "1028599167"
//        let url = "itms-apps://itunes.apple.com/app/id\(appId)"
//        UIApplication.shared.openURL(NSURL(string: url)! as URL)
        let storeViewController = SKStoreProductViewController()
        // storeViewController.delegate = self
        
        let parameters = [ SKStoreProductParameterITunesItemIdentifier : appId]
        storeViewController.loadProduct(withParameters: parameters) { [weak self] (loaded, error) -> Void in
            if loaded {
                // Parent class of self is UIViewController
                self?.present(storeViewController, animated: true, completion: nil)
            }
        }
    }
    func productViewControllerDidFinish(_ viewController: SKStoreProductViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
}

