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
//         UITabBar.appearance().barTintColor = #colorLiteral(red: 0.1607843137, green: 0.168627451, blue: 0.2078431373, alpha: 1)
        UITabBar.appearance().barTintColor = #colorLiteral(red: 0.2156862745, green: 0.2352941176, blue: 0.3960784314, alpha: 1)
         UITabBar.appearance().tintColor = #colorLiteral(red: 0.2196078431, green: 0.8117647059, blue: 0.5882352941, alpha: 1)
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
        CoreDataStack.shared.saveContext()
    }
}
