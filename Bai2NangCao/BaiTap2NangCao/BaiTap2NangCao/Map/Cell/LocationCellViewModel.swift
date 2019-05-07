//
//  LocationCellViewModel.swift
//  BaiTap2NangCao
//
//  Created by MBA0023 on 5/6/19.
//  Copyright © 2019 MBA0023. All rights reserved.
//

import Foundation
import MapKit

final class LocationCellViewModel {

    var location: Location?
    var latlong: CLLocationCoordinate2D? {
        return location?.latlong
    }
    var name: String? {
        return location?.name
    }

    init(location: Location?) {
        self.location = location
    }
}
