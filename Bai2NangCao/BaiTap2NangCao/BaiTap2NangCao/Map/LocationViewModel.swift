//
//  LocationViewModel.swift
//  BaiTap2NangCao
//
//  Created by MBA0023 on 5/6/19.
//  Copyright © 2019 MBA0023. All rights reserved.
//

import Foundation
import MapKit

final class LocationViewModel {

    var locations: [Location] = []
    var locationSelected: Location?

    func getData() {
        locations = Dummy.locations
    }

    func numberOfItems() -> Int {
        return locations.count
    }

    func viewModelForItems(at indexPath: IndexPath) -> LocationCellViewModel {
        return LocationCellViewModel(location: locations[indexPath.row])
    }

    func viewModelForMapView(radius: Double) -> MapViewModel {
        return MapViewModel(location: locationSelected, radius: radius)
    }

    func selectLocation(at indexPath: IndexPath) {
        locationSelected = locations[indexPath.row]
    }
}

extension LocationViewModel {

    struct Dummy {
        static let locations: [Location] = {
            let location1 = Location(name: "Location 1", latlong: CLLocationCoordinate2D(latitude: 16.080595, longitude: 108.238134))
            let location2 = Location(name: "Location 2", latlong: CLLocationCoordinate2D(latitude: 16.080605, longitude: 108.239023))
            let location3 = Location(name: "Location 3", latlong: CLLocationCoordinate2D(latitude: 16.080513, longitude: 108.236927))
            let location4 = Location(name: "Location 4", latlong: CLLocationCoordinate2D(latitude: 16.080941, longitude: 108.2350052))
            return [location1, location2, location3, location4]
        }()
    }
}
