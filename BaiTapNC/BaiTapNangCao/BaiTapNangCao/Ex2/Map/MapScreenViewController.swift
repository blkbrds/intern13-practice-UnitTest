//
//  MapScreenViewController.swift
//  BaiTapNangCao
//
//  Created by MBA0144 on 5/7/19.
//  Copyright © 2019 MBA0144. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps

final class MapScreenViewController: UIViewController {

    @IBOutlet private weak var mapView: GMSMapView!

    private let locationManager = CLLocationManager()
    var viewModel: MapScreenViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        configLocation()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configMap()
    }

    private func configLocation() {
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
    }

    private func configMap() {
        guard let viewModel = viewModel, let location = mapView.myLocation else { return }
        for geo in viewModel.geotifications {
            startMonitoring(geotification: geo)
            let marker = GMSMarker(position: geo.coordinate)
            marker.map = mapView
            let circle = GMSCircle(position: geo.coordinate, radius: geo.radius)
            circle.fillColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 0.451446963)
            circle.strokeColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            circle.strokeWidth = 1
            circle.map = mapView
        }
        mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
    }

    private func showAlert(error: String, msg: String) {
        present(UIAlertController(title: error, message: msg, preferredStyle: .alert), animated: true)
    }

    private func startMonitoring(geotification: Geotification) {
        guard CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) else {
            showAlert(error: "Error", msg: "Geofencing is not supported on this device!")
            return
        }
        guard CLLocationManager.authorizationStatus() == .authorizedAlways else {
            showAlert(error: "Error", msg: "Please grant location service")
            return
        }
        guard let fenceRegion = viewModel?.region(geotification: geotification) else { return }
        locationManager.startMonitoring(for: fenceRegion)
    }

    private func stopMonitoring(geotification: Geotification) {
        for region in locationManager.monitoredRegions {
            guard let circularRegion = region as? CLCircularRegion, circularRegion.identifier == geotification.id else { continue }
            locationManager.stopMonitoring(for: circularRegion)
        }
    }
}

extension MapScreenViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedAlways else { return }
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }
}


