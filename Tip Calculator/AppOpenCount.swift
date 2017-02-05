//
//  AppOpenCount.swift
//  Blue Tip Calculator
//
//  Created by Daniel Pratt on 2/4/17.
//  Copyright © 2017 blaumagier. All rights reserved.
//

import UIKit
import StoreKit

extension ViewController {
    
    // Load user default with how many times user has opened the app
    
    func updateTimesUserHasOpenedApp() {
        timesUserHasOpenedApp = UserDefaults.standard.integer(forKey: "timesUserHasOpenedApp_")
        doNotBugToRate = UserDefaults.standard.bool(forKey: "doNotBugToRate_")
        if timesUserHasOpenedApp == nil || doNotBugToRate == nil {
            timesUserHasOpenedApp = 1
            doNotBugToRate = false
            setNotToBugUser()
        } else if !doNotBugToRate! {
            timesUserHasOpenedApp = timesUserHasOpenedApp! + 1
            setTimesUserHasOpenedApp()
        }
    }
    
    func setTimesUserHasOpenedApp() {
        UserDefaults.standard.set(timesUserHasOpenedApp, forKey: "timesUserHasOpenedApp_")
    }
    
    func setNotToBugUser() {
        UserDefaults.standard.set(doNotBugToRate, forKey: "doNotBugToRate_")
    }
    
    func goToAppInAppStore() {
        let appId = "1028599167"
        
        let storeViewController = SKStoreProductViewController()
        storeViewController.delegate = self
        
        let parameters = [ SKStoreProductParameterITunesItemIdentifier : appId]
        storeViewController.loadProduct(withParameters: parameters) { [weak self] (loaded, error) -> Void in
            if loaded {
                // Parent class of self is UIViewController
                self?.present(storeViewController, animated: true, completion: nil)
            }
        }
    }
    
    func productViewControllerDidFinish(_ viewController: SKStoreProductViewController) {
        viewController.dismiss(animated: true, completion: {
        doNotBugToRate = true
        self.setNotToBugUser()
        })
    }

    
}
