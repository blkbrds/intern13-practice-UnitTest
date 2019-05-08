//
//  HomeRemindViewController.swift
//  ViperSample
//
//  Created by MBA0010 on 5/6/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import UIKit
import GoogleMaps

final class HomeRemindViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet private weak var mapView: GMSMapView!
    @IBOutlet private weak var userLocationBarButton: UIBarButtonItem!
    @IBOutlet private weak var addRemindBarButton: UIBarButtonItem!
    @IBOutlet private weak var navigationBar: UINavigationBar!
    @IBOutlet private weak var navigationItems: UINavigationItem!
    
    // MARK: - Properties
    var locationManager = CLLocationManager()
    var viewModel = HomeRemindViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configLocationService()
        configMapView()
        reloadDataInputMapView()
        updateGeoLocationsCounter()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        locationManager.startUpdatingLocation()
    }
    
    private func configLocationService() {
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
    }
    
    private func configMapView() {
        mapView.isMyLocationEnabled = true
        mapView.delegate = self
    }
    
    // MARK: Loading and saving functions
    private func reloadDataInputMapView() {
        for circle in viewModel.circles {
            circle.map = mapView
        }
        for mk in viewModel.markers {
            mk.map = mapView
        }
        mapView.reloadInputViews()
    }
    
    private func removeMarker(_ geoLocation: GeoMarker) {
        let maker = mapView.selectedMarker
        for i in 0..<viewModel.markers.count where viewModel.markers[i] == maker {
            viewModel.markers[i].map = nil
            viewModel.circles[i].map = nil
        }
        mapView.reloadInputViews()
        updateGeoLocationsCounter()
    }
    
    private func updateGeoLocationsCounter() {
        navigationItems.title = "Locations makered: \(viewModel.geoLocations.count)"
        navigationItem.rightBarButtonItem?.isEnabled = (viewModel.geoLocations.count < 20)
    }
    
    private func saveAllGeoLocations() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(viewModel.geoLocations)
            UserDefaults.standard.set(data, forKey: PreferencesKeys.savedItems)
        } catch {
            print("error encoding geoLocations")
        }
    }
    
    // MARK: - Add Moniter
    func region(with geoLocation: GeoMarker) -> CLCircularRegion {
        let region = CLCircularRegion(center: geoLocation.coordinate, radius: geoLocation.radius, identifier: geoLocation.identifier)
        region.notifyOnEntry = (geoLocation.eventType == .onEntry)
        region.notifyOnExit = !region.notifyOnEntry
        return region
    }
    
    func startMonitoring(geoLocation: GeoMarker) {
        if !CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
            showAlert(withTitle:"Error", message: "Geofencing is not supported on this device!")
            return
        }
        
        if CLLocationManager.authorizationStatus() != .authorizedAlways {
            let message = "Your geotification is saved but will only be activated once you grant Geotify permission to access the device location."
            showAlert(withTitle:"Warning", message: message)
        }
        
        let fenceRegion = region(with: geoLocation)
        locationManager.startMonitoring(for: fenceRegion)
    }
    
    func stopMonitoring(geoLocation: GeoMarker) {
        for region in locationManager.monitoredRegions {
            guard let circularRegion = region as? CLCircularRegion, circularRegion.identifier == geoLocation.identifier else { continue }
            locationManager.stopMonitoring(for: circularRegion)
        }
    }
    
    // MARK: - IBActions
    @IBAction private func zoomToUserLocationBarButtonTouchUpInside(_ sender: Any) {
        locationManager.startUpdatingLocation()
    }
    
    @IBAction private func addRemindLocationBarButtonTouchUpInside(_ sender: Any) {
        let addRemindVC = AddRemindLocationViewController()
        addRemindVC.delegate = self
        present(addRemindVC, animated: true, completion: nil)
    }
    
}

// MARK: - Location Manager Delegate
extension HomeRemindViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let marker = GMSMarker(position: location.coordinate)
        marker.title = "User location"
        marker.appearAnimation = .pop
        marker.icon = #imageLiteral(resourceName: "marker")
        marker.map = mapView
        let camera = GMSCameraPosition(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 10.0)
        mapView?.animate(to: camera)
        
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        mapView.isMyLocationEnabled = status == .authorizedAlways
    }
    
    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        print("Monitoring failed for region with identifier: \(region?.identifier ?? "")")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location Manager failed with the following error: \(error)")
    }
    
}

// MARK: - Extension CGMapViewDelegate
extension HomeRemindViewController: GMSMapViewDelegate {
}

// MARK: - Extension
extension HomeRemindViewController: AddRemindLocationViewControllerDelegate {
    
    func controller(_ controller: AddRemindLocationViewController, needPerform action: AddRemindLocationViewController.Action) {
        switch action {
        case .addRemind(let geoLocation):
            controller.dismiss(animated: true, completion: nil)
            viewModel.geoLocations.append(geoLocation)
            saveAllGeoLocations()
            startMonitoring(geoLocation: geoLocation)
            reloadDataInputMapView()
            updateGeoLocationsCounter()
        }
    }
}
