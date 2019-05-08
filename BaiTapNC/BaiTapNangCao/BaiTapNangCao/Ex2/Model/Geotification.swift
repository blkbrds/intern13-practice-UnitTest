//
//  Geotification.swift
//  BaiTapNangCao
//
//  Created by MBA0144 on 5/7/19.
//  Copyright © 2019 MBA0144. All rights reserved.
//

import Foundation
import CoreLocation

final class Geotification {

    var coordinate = CLLocationCoordinate2D()
    var radius: CLLocationDistance = 0
    var zone = ""

    init(coordinate: CLLocationCoordinate2D, radius: CLLocationDistance, zone: String) {
        self.coordinate = coordinate
        self.radius = radius
        self.zone = zone
    }

    init() { }
}
