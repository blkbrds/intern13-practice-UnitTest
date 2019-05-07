//
//  AppDelegate.swift
//  ViperSample
//
//  Created by Van Le H. on 4/3/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import UIKit
import CoreLocation
import UserNotifications
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let locationManager = CLLocationManager()
    let googleApiKey = "AIzaSyA1aLTWMyVn-9Y2Bk59R79JJtnRzLLJF1M"

//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        // Override point for customization after application launch.
//        window?.rootViewController = UINavigationController(rootViewController: loginViewController())
//        window?.makeKeyAndVisible()
//        return true
//    }
//
//    private func loginViewController() -> LoginViewController {
//        let vc = LoginViewController()
//        let router = DefaultLoginRouter()
//        router.viewController = vc
//        let interactor = DefaultLoginInteractor()
//        let presenter = DefaultLoginPresenter(view: vc, router: router, loginInteractor: interactor)
//        vc.eventHandler = presenter
//        return vc
//    }
    
    // MARK: - Life cycle
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:[UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        window = UIWindow(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        let vc = HomeRemindViewController()
        window?.rootViewController = vc
        
        configLocationService()
        configGoogleMap()
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        application.applicationIconBadgeNumber = 0
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
    
    // MARK: - Locaion Service
    func configLocationService() {
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        let options: UNAuthorizationOptions = [.badge, .sound, .alert]
        UNUserNotificationCenter.current()
            .requestAuthorization(options: options) { success, error in
                if let error = error {
                    print("Error: \(error)")
                }
        }
    }
    
    // MARK: - Google map
    func configGoogleMap() {
        GMSServices.provideAPIKey(googleApiKey)
    }
    
    func handleEvent(for region: CLRegion!) {
        // Show an alert if application is active
        if UIApplication.shared.applicationState == .active {
            guard let message = note(from: region.identifier) else { return }
            window?.rootViewController?.showAlert(withTitle: nil, message: message)
        } else {
            // Otherwise present a local notification
            guard let body = note(from: region.identifier) else { return }
            let notificationContent = UNMutableNotificationContent()
            notificationContent.body = body
            notificationContent.sound = UNNotificationSound.default
            notificationContent.badge = UIApplication.shared.applicationIconBadgeNumber + 1 as NSNumber
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
            let request = UNNotificationRequest(identifier: "location_change",
                                                content: notificationContent,
                                                trigger: trigger)
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Error: \(error)")
                }
            }
        }
    }
    
    func note(from identifier: String) -> String? {
        let geolocations = GeoMarker.allGeoLocation()
        guard let matched = geolocations.filter({
            $0.identifier == identifier
        }).first else { return nil }
        return matched.note
    }
}

extension AppDelegate: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        if region is CLCircularRegion {
            handleEvent(for: region)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        if region is CLCircularRegion {
            handleEvent(for: region)
        }
    }
}
