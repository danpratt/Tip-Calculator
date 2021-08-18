//
//  PeopleInterfaceController.swift
//  Blue Tip Calculator
//
//  Created by Daniel Pratt on 11/18/15.
//  Copyright © 2015 blaumagier. All rights reserved.
//

import WatchKit
import Foundation


class OptionsController: WKInterfaceController {

    @IBOutlet weak var peoplePicker: WKInterfacePicker!
    @IBOutlet weak var tipSizePicker: WKInterfacePicker!
    
    // shared instance
    var tipCalculator = BTCTipCalculator.sharedInstance
    
    // Variables for picker values
    var people : Int?
    var peoplePickerData : [WKPickerItem]!
    var tipPickerData : [WKPickerItem]!
    
    // id used for localization, defaults to english
    var localeLanguageID: String = "en"
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // setup localization id first
        if let language = Locale.current.languageCode {
            localeLanguageID = language
        }
        
        let one = WKPickerItem()
        one.title = "1"
        one.caption = justMeLocalized()
        let two = WKPickerItem()
        two.title = "2"
        two.caption = twoLocalized()
        let three = WKPickerItem()
        three.title = "3"
        three.caption = threeLocalized()
        let four = WKPickerItem()
        four.title = "4"
        four.caption = fourLocalized()
        let five = WKPickerItem()
        five.title = "5"
        five.caption = fiveLocalized()
        let six = WKPickerItem()
        six.title = "6"
        six.caption = sixLocalized()
        peoplePickerData = [one, two, three, four, five, six]
        peoplePicker.setItems(peoplePickerData)
        
        let ten = WKPickerItem()
        ten.title = "10%"
        ten.caption = tenPercentTipLocalized()
        let fiften = WKPickerItem()
        fiften.title = "15%"
        fiften.caption = fifteenPercentTipLocalized()
        let eighteen = WKPickerItem()
        eighteen.title = "18%"
        eighteen.caption = eighteenPercentTipLocalized()
        let twenty = WKPickerItem()
        twenty.title = "20%"
        twenty.caption = twentyPercentTipLocalized()
        let twentyFive = WKPickerItem()
        twentyFive.title = "25%"
        twentyFive.caption = twentyFivePercentTipLocalized()
        tipPickerData = [ten, fiften, eighteen, twenty, twentyFive]
        tipSizePicker.setItems(tipPickerData)
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        // set current tip picker item to whatever is in the shared instance
        tipSizePicker.setSelectedItemIndex(tipCalculator.tipPercentValue.hashValue)
        
        // set current numPeople item to whatever is in the shared instance
        let numPeopleItem = tipCalculator.numPeopleSplittingBill - 1
        peoplePicker.setSelectedItemIndex(numPeopleItem)
        
    }

    @IBAction func peoplePickerChanged(_ value: Int) {
        people = value + 1
        tipCalculator.setNumPeopleSplitting(numPeople: people!)
    }
    
    @IBAction func tipPercentPickerChanged(_ value: Int) {
        tipCalculator.setTipPercentValue(tipPercent: TipPercentValue.fromHashValue(hashValue: value))
    }
}
