//
//  AppDelegate.swift
//  TreeView
//
//  Created by MBA0265P on 5/2/19.
//  Copyright © 2019 MBA0265P. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)

        let vc = TreeViewController()
        window?.rootViewController = UINavigationController(rootViewController: vc)

        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        return true
    }
}

