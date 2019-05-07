//
//  HomeRemindViewModel.swift
//  ViperSample
//
//  Created by MBA0010 on 5/6/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import Foundation
import GoogleMaps

final class HomeRemindViewModel {
    
    var geoLocations: [GeoMarker] = [] {
        didSet {
            addMarkers()
            addCirles()
        }
    }
    var markers: [GMSMarker] = []
    var circles: [GMSCircle] = []
    
    func addMarkers() {
        for geoLocation in geoLocations {
            let marker = GMSMarker(position: geoLocation.coordinate)
            marker.title = geoLocation.title
            marker.snippet = geoLocation.subtitle
            marker.appearAnimation = .pop
            marker.icon = #imageLiteral(resourceName: "marker")
            markers.append(marker)
        }
    }
    
    func addCirles() {
        for geoLocation in geoLocations {
            let circle = GMSCircle()
            circle.radius = geoLocation.radius
            circle.fillColor = UIColor.gray.withAlphaComponent(0.5)
            circle.position = geoLocation.coordinate
            circle.strokeWidth = 1
            circle.strokeColor = UIColor.black
            circles.append(circle)
        }
    }
}
