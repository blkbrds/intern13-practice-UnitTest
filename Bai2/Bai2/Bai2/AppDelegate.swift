//
//  AppDelegate.swift
//  Bai2
//
//  Created by MBA0023 on 5/7/19.
//  Copyright © 2019 MBA0023. All rights reserved.
//

import UIKit
import GoogleMaps
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let googleApiKey = "AIzaSyC-ZYrwJkE3TKgjqbvF9xBco15lVq2ZGK4"
    let notificationCenter = UNUserNotificationCenter.current()

    static let shared: AppDelegate = {
        guard let shared = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Cannot cast `UIApplication.shared.delegate` to `AppDelegate`.")
        }
        return shared
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let navigationController = UINavigationController(rootViewController: MapViewController())
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        GMSServices.provideAPIKey(googleApiKey)
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        notificationCenter.requestAuthorization(options: options) {
            (didAllow, error) in
            if !didAllow {
                print("User has declined notifications")
            }
        }
        return true
    }

    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Danger"
        content.body = "You are in danger area, please move out"
        content.sound = UNNotificationSound.default
        content.badge = 0
        let date = Date(timeIntervalSinceNow: 1)
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: "content", content: content, trigger: trigger)
        notificationCenter.delegate = self
        notificationCenter.add(request) { (error) in
            if error != nil {
                print(error ?? "")
            }
        }
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
}
