//
//  RemindLocationViewController.swift
//  RemindLocation
//
//  Created by MBA0265P on 5/7/19.
//  Copyright © 2019 MBA0265P. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation

final class RemindLocationViewController: UIViewController {
    
    // MARK: - Outlet
    @IBOutlet weak var mapView: GMSMapView!
    
    // MARK: - Properties
    let locationManager = CLLocationManager()
    var locations = [Location]()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLocationServices()
    }
    
    // MARK: - Privates
    private func configureLocationServices() {
        locationManager.delegate = self
        mapView.delegate = self
        AppDelegate.shared.configureLocationServices()
    }
    
    private func handleLocationWhenSelected(at coordinate: CLLocationCoordinate2D) {
        // Handle marker
        let marker = GMSMarker()
        marker.position = coordinate
        marker.title = "Reminder from application"
        marker.snippet = "Da Nang"
        marker.map = mapView
        
        // Handle circle
        let circle = GMSCircle(position: coordinate, radius: 1000)
        circle.fillColor = UIColor.red.withAlphaComponent(0.2)
        circle.strokeColor = .red
        circle.strokeWidth = 2.0
        circle.map = mapView
        
        let location = Location(coordinate: coordinate, radius: 1000)
        locations.append(location)
    }
    
    private func handleShowNotify(at coordinate: CLLocationCoordinate2D) {
        guard let myLocation = mapView.myLocation?.coordinate else { return }
        let userLocation = CLLocation(latitude: myLocation.latitude, longitude: myLocation.longitude)
        let warninglocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let distance = userLocation.distance(from: warninglocation)
        if distance <= 1000 {
            AppDelegate.shared.scheduleLocalNotification()
        }
    }
}

// MARK: - CLLocationManagerDelegate
extension RemindLocationViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        locationManager.startUpdatingLocation()
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        for location in locations {
            handleShowNotify(at: location.coordinate)
        }
    }
}

// MARK: - GMSMapViewDelegate
extension RemindLocationViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        handleLocationWhenSelected(at: coordinate)
        handleShowNotify(at: coordinate)
    }
}
