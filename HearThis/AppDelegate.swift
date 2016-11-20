//
//  AppDelegate.swift
//  HearThis
//
//  Created by Manuel Meyer on 17.11.16.
//  Copyright © 2016 Manuel Meyer. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "StartViewController")
        
        if let initialViewController = initialViewController as? HearThisPlayerHolder {
            initialViewController.hearThisPlayer = HearThisPlayer()
        }
        
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
        return true

    }


}

