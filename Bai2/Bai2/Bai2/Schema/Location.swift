//
//  Location.swift
//  Bai2
//
//  Created by MBA0023 on 5/7/19.
//  Copyright © 2019 MBA0023. All rights reserved.
//

import Foundation
import GoogleMaps

final class Loca {

    var latlong: CLLocationCoordinate2D?
    var radius: Double = 0

    init(latlong: CLLocationCoordinate2D, radius: Double) {
        self.latlong = latlong
        self.radius = radius
    }
}
