//
//  AppDelegate.swift
//  ViperSample
//
//  Created by Van Le H. on 4/3/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        window?.rootViewController = UINavigationController(rootViewController: loginViewController())
        
        let vc = TreeTableViewController()
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        return true
    }

    private func loginViewController() -> LoginViewController {
        let vc = LoginViewController()
        let router = DefaultLoginRouter()
        router.viewController = vc
        let interactor = DefaultLoginInteractor()
        let presenter = DefaultLoginPresenter(view: vc, router: router, loginInteractor: interactor)
        vc.eventHandler = presenter
        return vc
    }
}

