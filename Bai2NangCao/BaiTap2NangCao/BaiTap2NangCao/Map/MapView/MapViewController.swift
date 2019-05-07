//
//  MapViewController.swift
//  BaiTap2NangCao
//
//  Created by MBA0023 on 5/6/19.
//  Copyright © 2019 MBA0023. All rights reserved.
//

import UIKit
import MapKit

final class MapViewController: UIViewController {

    @IBOutlet private weak var mapView: MKMapView!

    var viewModel = MapViewModel()
    var userLocation: CLLocationCoordinate2D?

    override func viewDidLoad() {
        super.viewDidLoad()

        configLocationServices()
        configMapView()
        addAnnotation()
        addOverlayData()
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(MapViewController.back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
    }

    @objc func back(sender: UIBarButtonItem) {
        mapView.showsUserLocation = false
        _ = navigationController?.popViewController(animated: true)
    }

    func configLocationServices() {
        AppDelegate.shared.configLocationService()
    }

    func configMapView() {
        mapView.showsUserLocation = true
        let center = CLLocationCoordinate2DMake(16.0803605, 108.2384368)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        mapView.region = MKCoordinateRegion(center: center, span: span)
        mapView.delegate = self
    }

    func addAnnotation() {
        let annotation = MKPointAnnotation()
        guard let latlong = viewModel.location?.latlong else { return }
        annotation.coordinate = latlong
        annotation.title = "Danger"
        mapView.addAnnotation(annotation)
    }

    func addOverlayData() {
        guard let latlong = viewModel.location?.latlong else { return }
        let overlayData = MKCircle(center: latlong, radius: viewModel.radius)
        mapView.addOverlay(overlayData)
    }
}

extension MapViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            guard let latlong = viewModel.location?.latlong else { return nil }
            if viewModel.calDistanceBetween2Points(point1: latlong, point2: annotation.coordinate) <= viewModel.radius {
                AppDelegate.shared.scheduleNotification()
            }
            return nil
        }
        let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "MKPinAnnotationView")
        pin.animatesDrop = true
        pin.tintColor = .green
        pin.canShowCallout = true
        print("bbb")
        return pin
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let circle = overlay as? MKCircle else { return MKOverlayRenderer() }
        let circleRenderer = MKCircleRenderer(circle: circle)
        circleRenderer.fillColor = #colorLiteral(red: 0.8745327536, green: 0.02704223338, blue: 0.3644352708, alpha: 0.5753191021)
        circleRenderer.strokeColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        circleRenderer.lineWidth = 3
        circleRenderer.lineDashPhase = 10
        return circleRenderer
    }

    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let center = userLocation.coordinate
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        mapView.setRegion(MKCoordinateRegion(center: center, span: span), animated: true)
        mapView.addAnnotation(userLocation)
    }
}
