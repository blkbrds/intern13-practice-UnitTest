//
//  MapViewModel.swift
//  Bai2
//
//  Created by MBA0023 on 5/7/19.
//  Copyright © 2019 MBA0023. All rights reserved.
//

import Foundation
import GoogleMaps

final class MapViewModel {

    func calDistanceBetween2Points(point1: CLLocationCoordinate2D, point2: CLLocationCoordinate2D) -> Double {
        let R = 6371e3
        let la1 = point1.latitude
        let lo1 = point1.longitude
        let la2 = point2.latitude
        let lo2 = point2.longitude
        let dLat: Double = (la2 - la1) * (Double.pi / 180)
        let dLon: Double = (lo2 - lo1) * (Double.pi / 180)
        let la1ToRad = la1 * (Double.pi / 180)
        let la2ToRad = la2 * (Double.pi / 180)
        let a = sin(dLat / 2) * sin(dLat / 2) + cos(la1ToRad) * cos(la2ToRad) * sin(dLon / 2) * sin(dLon / 2)
        let c = 2 * atan2(sqrt(a), sqrt(1 - a))
        let d = R * c
        return d
    }

    func calRadius(radiusText: UITextField) -> Double {
        guard let radius1 = radiusText.text, let radius2 = Double(radius1) else { return 0 }
        return radius2
    }
}
