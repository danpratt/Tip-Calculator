//
//  OptionsControllerLocalizationMethods.swift
//  Blue Tip Wrist Calculator Extension
//
//  Created by Daniel Pratt on 11/9/17.
//  Copyright © 2017 blaumagier. All rights reserved.
//

import Foundation

extension OptionsController {
    // MARK: - Private Localization Methods
    
    func justMeLocalized() -> String {
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
    
    func twoLocalized() -> String {
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
    
    func threeLocalized() -> String {
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
    
    func fourLocalized() -> String {
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
    
    func fiveLocalized() -> String {
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
    
    func sixLocalized() -> String {
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
    
    func tenPercentTipLocalized() -> String {
        switch localeLanguageID {
        case "zh":
            return "子服务"
        default:
            return "Sub Par Service"
        }
    }
    
    func fifteenPercentTipLocalized() -> String {
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
    
    func eighteenPercentTipLocalized() -> String {
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
    
    func twentyPercentTipLocalized() -> String {
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
    
    func twentyFivePercentTipLocalized() -> String {
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
