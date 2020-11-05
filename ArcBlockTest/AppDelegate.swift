//
//  AppDelegate.swift
//  ArcBlockTest
//
//  Created by zY on 2020/11/4.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        initRootVC()
        return true
    }
    
    func initRootVC() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        self.window?.backgroundColor = UIColor.white        
        self.window?.rootViewController = ZYRootViewController()
    }

}

