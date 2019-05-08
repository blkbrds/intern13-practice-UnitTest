//
//  MapScreenViewModel.swift
//  BaiTapNangCao
//
//  Created by MBA0144 on 5/7/19.
//  Copyright © 2019 MBA0144. All rights reserved.
//

import Foundation
import CoreLocation

final class MapScreenViewModel {

    var geotifications: [Geotification] = []

    init(geotifications: [Geotification]) {
        self.geotifications = geotifications
    }

    func region(geotification: Geotification) -> CLCircularRegion {
        let region = CLCircularRegion(center: geotification.coordinate, radius: geotification.radius, identifier: geotification.zone)
        region.notifyOnEntry = true
        return region
    }
}
