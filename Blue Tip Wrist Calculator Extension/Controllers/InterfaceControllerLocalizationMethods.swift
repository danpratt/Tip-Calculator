//
//  InterfaceControllerLocalizationMethods.swift
//  Blue Tip Wrist Calculator Extension
//
//  Created by Daniel Pratt on 11/9/17.
//  Copyright © 2017 blaumagier. All rights reserved.
//

import Foundation

extension InterfaceController {
    // Localize error title
    func getLocalizedErrorTitle() -> String {
        switch localeLanguageID {
        case "nl":
            return "Voer Totaal in"
        case "zh":
            return "输入总计"
        case "de":
            return "Gesamtsumme eingeben"
        default:
            return "Enter Total"
        }
    }
    
    // Localize error message
    func getLocalizedErrorMessage() -> String {
        switch localeLanguageID {
        case "nl":
            return "Voer alstublieft de rekening totaal in voordat u de tip berekent"
        case "zh":
            return "计算提示前请输入帐单"
        case "de":
            return "Bitte rechnen Sie die Summe ein, bevor Sie den Tipp berechnen"
        default:
            return "Please enter bill total before calculating tip"
        }
    }
    
    // Localization variables
    func billAmountString() -> String {
        switch localeLanguageID {
        case "nl":
            return "Rekening: "
        case "zh":
            return "帐单总额: "
        case "de":
            return "Rechnung: "
        default:
            return "Bill total: "
        }
    }
    
    func tipString() -> String {
        switch localeLanguageID {
        case "nl":
            return "Fooi: "
        case "zh":
            return "赏钱: "
        case "de":
            return "Trinkgeld: "
        default:
            return "Tip: "
        }
    }
    
    func totalPlusTipString() -> String {
        switch localeLanguageID {
        case "nl":
            return "Totaal+Fooi: "
        case "zh":
            return "总+小费: "
        case "de":
            return "Total+Trinkgeld: "
        default:
            return "Total+Tip: "
        }
    }
}
