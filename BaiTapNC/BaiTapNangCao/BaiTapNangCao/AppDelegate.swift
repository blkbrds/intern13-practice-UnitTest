//
//  AppDelegate.swift
//  BaiTapNangCao
//
//  Created by MBA0144 on 5/3/19.
//  Copyright © 2019 MBA0144. All rights reserved.
//

import UIKit
import GoogleMaps
import UserNotifications

let googleAPIKey = "AIzaSyDCNjk_eNkQub13THHAy4fH-ME3tb9in34"
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    lazy var locationManager = CLLocationManager()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()

        let vc = AppViewController()
        let navigationController = UINavigationController(rootViewController: vc)
        window?.rootViewController = navigationController

        configGoogleAPI()
        configLocation()
        configNotification()

        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        application.applicationIconBadgeNumber = 0
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }

    private func configGoogleAPI() {
        GMSServices.provideAPIKey(googleAPIKey)
    }

    private func configLocation() {
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
    }

    private func configNotification() {
        let options: UNAuthorizationOptions = [.badge, .sound, .alert]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (success, error) in
            if let error = error {
                print(error)
            }
        }
    }

    private func handleEvent(region: CLRegion) {
        if UIApplication.shared.applicationState == .active {
            let action = UIAlertAction(title: "OK", style: .destructive, handler: nil)
            let alert = UIAlertController(title: "ALERT", message: "You had entered " + region.identifier, preferredStyle: .alert)
            alert.addAction(action)
            window?.rootViewController?.present(alert, animated: true)
        } else {
            let notifyContent = UNMutableNotificationContent()
            notifyContent.sound = UNNotificationSound.default
            notifyContent.body = "You had entered" + region.identifier
            notifyContent.badge = UIApplication.shared.applicationIconBadgeNumber + 1 as NSNumber
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
            let request = UNNotificationRequest(identifier: "location_changed", content: notifyContent, trigger: trigger)
            UNUserNotificationCenter.current().add(request) { (error) in
                if let error = error {
                    print(error)
                }
            }
        }
    }
}

extension AppDelegate: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        handleEvent(region: region)
    }
}

