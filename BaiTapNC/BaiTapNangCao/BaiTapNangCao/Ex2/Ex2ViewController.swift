//
//  Ex2ViewController.swift
//  BaiTapNangCao
//
//  Created by MBA0144 on 5/3/19.
//  Copyright © 2019 MBA0144. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps
import SwifterSwift

final class Ex2ViewController: UIViewController {

    @IBOutlet private weak var mapView: GMSMapView!
    @IBOutlet private weak var radiusTextField: UITextField!
    @IBOutlet private weak var indentifyTextField: UITextField!
    @IBOutlet private weak var latitudeTextField: UITextField!
    @IBOutlet private weak var longtitudeTextField: UITextField!
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var alertLabel: UILabel!

    private var viewModel = Ex2ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }

    private func configView() {
        mapView.delegate = self
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        configNavigation()
    }

    private func configNavigation() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(gotoMap))
    }

    @objc private func gotoMap() {
        let mapVC = MapScreenViewController()
        mapVC.viewModel = viewModel.mapScreenViewModel()
        navigationController?.pushViewController(mapVC)
    }

    private func showAddedAlert() {
        alertLabel.isHidden = false
        UIView.animate(withDuration: 1.5, animations: { () -> Void in
            self.alertLabel.alpha = 0
        })
    }

    private func addMark(position: CLLocationCoordinate2D) {
        let mark = GMSMarker(position: position)
        mark.map = mapView
    }

    @IBAction func addButtonTouchUpInside(_ sender: Any) {
        guard let lat = latitudeTextField.text?.double(), let long = longtitudeTextField.text?.double() ,let radius = radiusTextField.text?.double(), let indentify = indentifyTextField.text else { return }
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        viewModel.addGeotification(coordinate: coordinate, radius: radius, id: indentify)
        addMark(position: coordinate)
        contentView.isHidden = true
        showAddedAlert()
    }
}

extension Ex2ViewController: GMSMapViewDelegate {

    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        latitudeTextField.text = "\(coordinate.latitude)"
        longtitudeTextField.text = "\(coordinate.longitude)"
        contentView.isHidden = false
    }
}
