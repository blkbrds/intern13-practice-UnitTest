//
//  AppDelegate.swift
//  RemindLocation
//
//  Created by MBA0265P on 5/7/19.
//  Copyright © 2019 MBA0265P. All rights reserved.
//

import UIKit
import CoreLocation
import UserNotifications
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    static let shared: AppDelegate = {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Can not cast to App Delegate")
        }
        return delegate
    }()
    
    typealias Action = (String?, (() -> Void)?)
    var window: UIWindow?
    lazy var locationManager = CLLocationManager()
    var notificationCenter: UNUserNotificationCenter?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        GMSServices.provideAPIKey("AIzaSyAZxaP77YW0m_gEm6pyot2C0z1CagBSyjo")
        
        self.notificationCenter = UNUserNotificationCenter.current()
        let options: UNAuthorizationOptions = [.alert]
        notificationCenter?.requestAuthorization(options: options, completionHandler: { (didAllow, error) in
        })
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        
        let vc = RemindLocationViewController()
        window?.rootViewController = UINavigationController(rootViewController: vc)
        
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func showAlert(title: String, message: String, actions: [Action]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            if let handler = action.1 {
                let alertAction = UIAlertAction(title: action.0, style: .default, handler: { (_) in
                    handler()
                })
                alert.addAction(alertAction)
            } else {
                let alertAction = UIAlertAction(title: action.0, style: .default, handler: nil)
                alert.addAction(alertAction)
            }
        }
        window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}

extension AppDelegate {
    
    func enableLocationServices() {
        CLLocationManager.locationServicesEnabled()
    }
    
    // Standard location service
    func startStandardLocationService() {
        locationManager.startUpdatingLocation()
    }
    
    func stopStandardLocationService() {
        locationManager.stopUpdatingLocation()
    }
    
    func configureLocationServices() {
        
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            enableLocationServices()
            startStandardLocationService()
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied:
            let title = "Request location service"
            let message = "Please go to Setting > Privacy > Location service to turn on location service for \"Map Demo\""
            let action: Action = ("OK", nil)
            showAlert(title: title, message: message, actions: [action])
        default:
            break
        }
    }
    
    func scheduleLocalNotification() {
        
        notificationCenter?.delegate = self
        
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = "You are go to where you turn on reminder, so please read its on your phone"
        content.sound = .default
    
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        
        let request = UNNotificationRequest(identifier: "local notification", content: content, trigger: trigger)
        
        notificationCenter?.add(request, withCompletionHandler: { (error) in
            if let error = error {
                print("Unable to Add Notification Request (\(error), \(error.localizedDescription))")
            }
        })
    }
}

extension AppDelegate:UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler(.alert)
    }
}
