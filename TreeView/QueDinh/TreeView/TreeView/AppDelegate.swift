//
//  AppDelegate.swift
//  TreeView
//
//  Created by MBA0023 on 4/15/19.
//  Copyright © 2019 MBA0023. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let navigationController = UINavigationController(rootViewController: HomeViewController())
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController;
        window?.makeKeyAndVisible()
        return true
    }
}
