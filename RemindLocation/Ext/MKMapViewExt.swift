//
//  MKMapViewExt.swift
//  ViperSample
//
//  Created by MBA0010 on 5/6/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import Foundation
import MapKit

extension MKMapView {
    func zoomToUserLocation() {
        guard let coordinate = userLocation.location?.coordinate else { return }
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        setRegion(region, animated: true)
    }
}
