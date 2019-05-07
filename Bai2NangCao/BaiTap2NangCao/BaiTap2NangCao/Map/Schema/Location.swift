//
//  Location.swift
//  BaiTap2NangCao
//
//  Created by MBA0023 on 5/6/19.
//  Copyright © 2019 MBA0023. All rights reserved.
//

import Foundation
import MapKit

final class Location {

    var name = ""
    var latlong: CLLocationCoordinate2D

    init(name: String, latlong: CLLocationCoordinate2D) {
        self.name = name
        self.latlong = latlong
    }
}
