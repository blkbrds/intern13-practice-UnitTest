//
//  AddRemindLocationViewController.swift
//  ViperSample
//
//  Created by MBA0010 on 5/6/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import UIKit
import GoogleMaps

protocol AddRemindLocationViewControllerDelegate: class {
    func controller(_ controller: AddRemindLocationViewController, needPerform action: AddRemindLocationViewController.Action)
}

final class AddRemindLocationViewController: UIViewController {
    
    enum Action {
        case addRemind(geoLocation: GeoMarker)
    }
    
    // MARK: - Outlets
    @IBOutlet private weak var exitButton: UIButton!
    @IBOutlet private weak var entryButton: UIButton!
    @IBOutlet private weak var addBarButton: UIBarButtonItem!
    @IBOutlet private weak var cancelBarButton: UIBarButtonItem!
    @IBOutlet private weak var zoomUserBarButton: UIBarButtonItem!
    @IBOutlet private weak var mapView: GMSMapView!
    @IBOutlet private weak var radiusTextField: UITextField!
    @IBOutlet private weak var noteTextField: UITextField!
    
    var delegate: AddRemindLocationViewControllerDelegate?
    var locationManager = CLLocationManager()
    var type: GeoMarker.EventType = .onEntry {
        didSet {
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configLocationService()
        configMapView()
        updateUI()
    }
    
    private func configLocationService() {
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    private func configMapView() {
        mapView.isMyLocationEnabled = true
        mapView.delegate = self
    }
    
    private func updateUI() {
        entryButton.backgroundColor = type == .onEntry ? .green : .white
        exitButton.backgroundColor = type == .onEntry ? .white : .green
    }
    
    // MARK: - IBAction
    @IBAction private func cancelButtonTouchUpInside(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func addButtonTouchUpInside(_ sender: Any) {
        guard let radiusString = radiusTextField.text,
            let radius = Double(radiusString),
            let note = noteTextField.text else { return }
        let coordinate = mapView.camera.target
        let identifier = NSUUID().uuidString
        let geoLocation = GeoMarker(coordinate: coordinate, radius: radius, identifier: identifier, note: note, eventType: type)
        delegate?.controller(self, needPerform: .addRemind(geoLocation: geoLocation))
    }
    
    @IBAction private func zoomToUserLocationTouchUpInside(_ sender: Any) {
        locationManager.startUpdatingLocation()
    }
    
    @IBAction private func textFieldDidChange(_ sender: Any) {
        guard let radius = radiusTextField.text,
            let note = noteTextField.text else { return }
        addBarButton.isEnabled = !radius.isEmpty && !note.isEmpty
    }
    
    @IBAction private func selectTypeButtonTouchUpInside(_ sender: UIButton) {
        type = sender.tag == 0 ? .onEntry : .onExit
    }
    
}

extension AddRemindLocationViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let marker = GMSMarker(position: location.coordinate)
        marker.title = "User location"
        marker.appearAnimation = .pop
        marker.icon = #imageLiteral(resourceName: "marker")
        mapView.clear()
        marker.map = mapView
        let camera = GMSCameraPosition(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 17.0)
        mapView?.animate(to: camera)
        
        locationManager.stopUpdatingLocation()
    }
}

extension AddRemindLocationViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        let marker = GMSMarker(position: position.target)
        marker.title = "Loccation will be add remind."
        marker.appearAnimation = .pop
        marker.icon = #imageLiteral(resourceName: "marker")
        mapView.clear()
        marker.map = mapView
        mapView.reloadInputViews()
    }
}
