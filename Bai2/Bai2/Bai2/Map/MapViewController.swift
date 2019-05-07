//
//  MapViewController.swift
//  Bai2
//
//  Created by MBA0023 on 5/7/19.
//  Copyright © 2019 MBA0023. All rights reserved.
//

import UIKit
import GoogleMaps
import AVFoundation

final class MapViewController: UIViewController {

    @IBOutlet private weak var mapView: GMSMapView!
    @IBOutlet private weak var radiusTextField: UITextField!
    
    private let locationManager = CLLocationManager()
    var makers: [GMSMarker] = []
    var viewModel = MapViewModel()
    var locas: [Loca] = []
    var distance: Double = 0
    var player: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()

        configGMSMapView()
    }

    private func configGMSMapView() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        mapView.delegate = self
    }

    func playSound() {
        guard let url = Bundle.main.url(forResource: "danger", withExtension: "mp3") else {
            print("url not found")
            return
        }
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            player?.numberOfLoops = 2
            player!.play()
        } catch let error as NSError {
            print("error: \(error.localizedDescription)")
        }
    }
}

extension MapViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else {
            return
        }
        locationManager.startUpdatingLocation()
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        for loca in locas {
            guard let point1 = mapView.myLocation?.coordinate, let latlong = loca.latlong else { return }
            distance = viewModel.calDistanceBetween2Points(point1: point1, point2: latlong)
            if distance <= loca.radius {
                AppDelegate.shared.scheduleNotification()
                playSound()
            }
        }
    }
}

extension MapViewController: GMSMapViewDelegate {

    func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
        let marker = GMSMarker()
        marker.position = coordinate
        marker.title = "Danger"
        marker.map = mapView

        let circleCenter = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let circ = GMSCircle(position: circleCenter, radius: viewModel.calRadius(radiusText: radiusTextField))
        circ.fillColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 0.586212588)
        circ.strokeColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        circ.map = mapView
        let location = Loca(latlong: coordinate, radius: viewModel.calRadius(radiusText: radiusTextField))
        locas.append(location)

        guard let userLocation = mapView.myLocation?.coordinate else { return }
        let distance = viewModel.calDistanceBetween2Points(point1: userLocation, point2: coordinate)
        if distance <= viewModel.calRadius(radiusText: radiusTextField) {
            AppDelegate.shared.scheduleNotification()
            playSound()
        }
    }
}
