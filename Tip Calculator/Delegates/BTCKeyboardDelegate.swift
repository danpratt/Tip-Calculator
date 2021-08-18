//
//  BTCKeyboardDelegate.swift
//  Blue Tip Calculator
//
//  Created by Daniel Pratt on 11/9/17.
//  Copyright © 2017 blaumagier. All rights reserved.
//

import Foundation
import UIKit

extension BTCMainViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let  char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        
        if (isBackSpace == -92) {
            return true
        }
        
        // Load up the character set of acceptable keys to be pressed, this is important for iPad users
        let characterset = CharacterSet(charactersIn: "0123456789" + (Locale.current.decimalSeparator)!)
        
        // prevent non numbers from being entered
        if string.rangeOfCharacter(from: characterset.inverted) != nil {
            // User entered something other than a number or decimal...
            print("The string contained \(String(describing:string))")
            return false
        }
        
        // Check if textfield already contains a decimal
        if (textField.text?.contains("."))! || (textField.text?.contains(","))! {
            // Found a decimal, check if the current character(s) have decimals in them
            if string.contains(".") || string.contains(",") {
                return false
            } else {
                // get the index near the end and check to see if it is a decimal
                // if it is, we can have one more character
                // if it isn't, we have to block entry
                
                let index = textField.text?.index((textField.text?.endIndex)!, offsetBy: -1)
                let checkChar = textField.text?[index!]
                
                // Check the last entered character
                if checkChar == "." || checkChar == "," {
                    return true
                }
                
                if (textField.text?.count)! > 2 {
                    let secondIndex = textField.text?.index((textField.text?.endIndex)!, offsetBy: -2)
                    let checkSecondChar = textField.text?[secondIndex!]
                    if checkSecondChar == "." || checkSecondChar == "," {
                        return true
                    } else {
                        // we already have two decimals so stop
                        print("String: \(string) is rejected from second char")
                        return false
                    }
                } else {
                    // we don't have enough characters to have more than two after the decimal so keep going
                    return true
                }
            }
        }
        // everything is fine, keep going
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        calculateTip()
        return true
    }
    
    // MARK: - Private Helper Functions
    
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

extension UITextField {
    
    func addDoneButtonToKeyboard(myAction:Selector?){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
        doneToolbar.barStyle = UIBarStyle.default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: myAction)
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
}


