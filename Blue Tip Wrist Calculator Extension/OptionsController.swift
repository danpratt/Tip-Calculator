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
    
    var people : Int?
    var peoplePickerData : [WKPickerItem]!
    var tipPickerData : [WKPickerItem]!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        // Configure interface objects here.
        let one = WKPickerItem()
        one.title = "1"
        one.caption = "Just Me"
        let two = WKPickerItem()
        two.title = "2"
        two.caption = "Me and One Other"
        let three = WKPickerItem()
        three.title = "3"
        three.caption = "Me and Two Others"
        let four = WKPickerItem()
        four.title = "4"
        four.caption = "Me and Three Others"
        let five = WKPickerItem()
        five.title = "5"
        five.caption = "Me and Four Others"
        let six = WKPickerItem()
        six.title = "6"
        six.caption = "A Party!"
        peoplePickerData = [one, two, three, four, five, six]
        peoplePicker.setItems(peoplePickerData)
        
        let ten = WKPickerItem()
        ten.title = "10%"
        ten.caption = "Sub Par Service"
        let fiften = WKPickerItem()
        fiften.title = "15%"
        fiften.caption = "Normal Service"
        let eighteen = WKPickerItem()
        eighteen.title = "18%"
        eighteen.caption = "Above Average Service"
        let twenty = WKPickerItem()
        twenty.title = "20%"
        twenty.caption = "Great Service"
        let twentyFive = WKPickerItem()
        twentyFive.title = "25%"
        twentyFive.caption = "Legendary Service"
        tipPickerData = [ten, fiften, eighteen, twenty, twentyFive]
        tipSizePicker.setItems(tipPickerData)
        
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func peoplePickerChanged(_ value: Int) {
//        print("value changed to \(value)")
        people = value + 1
        SharedData.sharedInstance.numPeople = self.people!
//        print(people)
    }
    
    @IBAction func tipPercentPickerChanged(_ value: Int) {
//        print(value)
        switch value {
        case 0:
            SharedData.sharedInstance.tipPercent = 0.10
        case 1:
            SharedData.sharedInstance.tipPercent = 0.15
        case 2:
            SharedData.sharedInstance.tipPercent = 0.18
        case 3:
            SharedData.sharedInstance.tipPercent = 0.20
        case 4:
            SharedData.sharedInstance.tipPercent = 0.25
        default:
            SharedData.sharedInstance.tipPercent = 0.15
        }
        
    }

}
