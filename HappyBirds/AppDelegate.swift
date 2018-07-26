//
//  AppDelegate.swift
//  HappyBirds
//
//  Created by Thao Doan on 7/21/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
         UITabBar.appearance().barTintColor = UIColor.black
         UITabBar.appearance().tintColor = #colorLiteral(red: 0, green: 0.8509803922, blue: 0.5529411765, alpha: 1)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
        CoreDataStack.share.saveContext()
    }
}
