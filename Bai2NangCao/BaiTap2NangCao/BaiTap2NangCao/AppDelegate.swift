//
//  AppDelegate.swift
//  BaiTap2NangCao
//
//  Created by MBA0023 on 5/6/19.
//  Copyright © 2019 MBA0023. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    typealias Action = (String?, (() -> Void)?)
    lazy var locationManager = CLLocationManager()
    let notificationCenter = UNUserNotificationCenter.current()

    static let shared: AppDelegate = {
        guard let shared = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Cannot cast `UIApplication.shared.delegate` to `AppDelegate`.")
        }
        return shared
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let navigationController = UINavigationController(rootViewController: LocationViewController())
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController;
        window?.makeKeyAndVisible()
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

    func configLocationService() {
        locationManager.delegate = self
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            enableLocationServices()
            startStandardLocationService()
        case .denied:
            let title = "Request location service"
            let message = "Please go to Setting > Privacy > Location service to turn on location service for \"Map Demo\""
            let action: Action = ("OK", nil)
            showAlert(title: title, message: message, actions: [action])
        case .restricted:
            break
        }
    }

    func showAlert(title: String, message: String, actions: [Action]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            if let _ = action.1 {
                let alertAction = UIAlertAction(title: action.0, style: .default, handler: { (_) in })
                alert.addAction(alertAction)
            } else {
                let alertAction = UIAlertAction(title: action.0, style: .default, handler: nil)
                alert.addAction(alertAction)
            }
        }
        window?.rootViewController?.present(alert, animated: true, completion: nil)
    }

    func enableLocationServices() {
        CLLocationManager.locationServicesEnabled()
    }

    func startStandardLocationService() {
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
    }

    func stopStandardLocationService() {
        locationManager.stopUpdatingLocation()
    }
}

extension AppDelegate: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted, .denied:
            stopStandardLocationService()
        case .authorizedWhenInUse, .authorizedAlways:
            enableLocationServices()
            startStandardLocationService()
        case .notDetermined:
            break
        }
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
}
