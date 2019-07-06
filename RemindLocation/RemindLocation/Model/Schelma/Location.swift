//
//  Location.swift
//  RemindLocation
//
//  Created by MBA0265P on 5/8/19.
//  Copyright © 2019 MBA0265P. All rights reserved.
//

import Foundation
import CoreLocation

final class Location {
    
    var coordinate: CLLocationCoordinate2D
    var radius: CLLocationDistance
    
    init(coordinate: CLLocationCoordinate2D, radius: CLLocationDistance) {
        self.coordinate = coordinate
        self.radius = radius
    }
}
