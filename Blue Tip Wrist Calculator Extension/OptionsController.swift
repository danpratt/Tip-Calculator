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
    
    // id used for localization, defaults to english
    var localeLanguageID: String = "en"
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // setup localization id first
        if let language = Locale.current.languageCode {
            localeLanguageID = language
        }
        
        print("The locale language code is: \(localeLanguageID)")
        
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
    
    // MARK: - Private Localization Methods
    
    private func justMeLocalized() -> String {
        switch localeLanguageID {
        case "nl":
            return "Alleen ik"
        case "zh":
            return "就我自己"
        case "de":
            return "Nur ich"
        default:
            return "Just Me"
        }
    }
    
    private func twoLocalized() -> String {
        switch localeLanguageID {
        case "nl":
            return "Mij en een andere"
        case "zh":
            return "我和另一个"
        case "de":
            return "Ich und eine andere"
        default:
            return "Me and One Other"
        }
    }
    
    private func threeLocalized() -> String {
        switch localeLanguageID {
        case "nl":
            return "Mij en twee anderen"
        case "zh":
            return "我和另外两个人"
        case "de":
            return "Ich und zwei andere"
        default:
            return "Me and Two Others"
        }
    }
    
    private func fourLocalized() -> String {
        switch localeLanguageID {
        case "nl":
            return "Me en drie anderen"
        case "zh":
            return "我和其他三人"
        case "de":
            return "Ich und drei andere"
        default:
            return "Me and Three Others"
        }
    }
    
    private func fiveLocalized() -> String {
        switch localeLanguageID {
        case "nl":
            return "Mij en vier anderen"
        case "zh":
            return "我和其他四人"
        case "de":
            return "Ich und vier andere"
        default:
            return "Me and Four Others"
        }
    }
    
    private func sixLocalized() -> String {
        switch localeLanguageID {
        case "nl":
            return "Een feest!"
        case "zh":
            return "派对!"
        case "de":
            return "Eine Partei!"
        default:
            return "A Party!"
        }
    }
    
    private func tenPercentTipLocalized() -> String {
        switch localeLanguageID {
        case "zh":
            return "子服务"
        default:
            return "Sub Par Service"
        }
    }

    private func fifteenPercentTipLocalized() -> String {
        switch localeLanguageID {
        case "nl":
            return "Normale Service"
        case "zh":
            return "正常服务"
        case "de":
            return "Normaler Service"
        default:
            return "Normal Service"
        }
    }
    
    private func eighteenPercentTipLocalized() -> String {
        switch localeLanguageID {
        case "nl":
            return "Bovenstaande Service"
        case "zh":
            return "高于平均水平服务"
        case "de":
            return "Überdurchschnittlicher"
        default:
            return "Above Average Service"
        }
    }
    
    private func twentyPercentTipLocalized() -> String {
        switch localeLanguageID {
        case "nl":
            return "Goede Service"
        case "zh":
            return "伟大的服务"
        case "de":
            return "Guter Service"
        default:
            return "Great Service"
        }
    }
    
    private func twentyFivePercentTipLocalized() -> String {
        switch localeLanguageID {
        case "nl":
            return "Legendarische Service"
        case "zh":
            return "传奇服务"
        case "de":
            return "Legendärer Service"
        default:
            return "Legendary Service"
        }
    }

}
