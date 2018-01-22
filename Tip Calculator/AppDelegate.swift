//
//  AppDelegate.swift
//  Tip Calculator
//
//  Created by Daniel Pratt on 8/4/15.
//  Copyright © 2015 blaumagier. All rights reserved.
//

import UIKit

// Enum for handling 3D touch homescreen shortcuts
enum ShortcutIDentifier: String {
    case TenPercentShortcut
    case FifteenPercentShortcut
    case TwentyPercentShortcut
    case LastTipShortcut
    
    init?(fullIdentifier: String) {
        guard let shortIdentifier =
            fullIdentifier.components(separatedBy: ".").last else {
                return nil
        }
        self.init(rawValue: shortIdentifier)
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var shortcutItem: UIApplicationShortcutItem?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // for handling shortcut launch
        var performShortcutDelegate = true
        
        if let shortcutItem = launchOptions?[UIApplicationLaunchOptionsKey.shortcutItem] as? UIApplicationShortcutItem {
            
            print("Application launched via shortcut")
            self.shortcutItem = shortcutItem
            
            performShortcutDelegate = false
        }
        return performShortcutDelegate
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        guard let shortcut = shortcutItem else { return }
        
        print("- Shortcut property has been set")
        
        let _ = handleShortcut(shortcutItem: shortcut)
        
        self.shortcutItem = nil
    }

    // MARK: - Handle Shortcuts
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        completionHandler(handleShortcut(shortcutItem: shortcutItem))
    }
    
    private func handleShortcut(shortcutItem: UIApplicationShortcutItem) -> Bool {
        let shortcutType = shortcutItem.type
        guard let shortcutIdentifier = ShortcutIDentifier(fullIdentifier: shortcutType) else {
            return false
        }
        switch shortcutIdentifier {
        case .TenPercentShortcut:
            return setTipSegment(to: 0)
        case .FifteenPercentShortcut:
            return setTipSegment(to: 1)
        case .TwentyPercentShortcut:
            return setTipSegment(to: 3)
        case .LastTipShortcut:
            guard let segment = shortcutItem.userInfo!["tipValueSegment"] as? Int else {
                return false
            }
            return setTipSegment(to: segment)
        }
    }

    // Set Tip Amount Segment Bar to Correct Segment
    private func setTipSegment(to segment: Int) -> Bool {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // this should never not work, but better to be safe than sorry!
        guard let blueTipCalculator = storyboard.instantiateViewController(withIdentifier: "blueTipCalculator") as? BTCMainViewController else {
            return false
        }
        
        blueTipCalculator.quickLaunchTipSegment = segment
        
        window?.rootViewController = blueTipCalculator
        
        return true
    }

}

