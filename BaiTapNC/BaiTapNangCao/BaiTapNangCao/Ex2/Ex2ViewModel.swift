//
//  Ex2ViewModel.swift
//  BaiTapNangCao
//
//  Created by MBA0144 on 5/7/19.
//  Copyright © 2019 MBA0144. All rights reserved.
//

import Foundation
import CoreLocation

final class Ex2ViewModel {

    private var geotifications: [Geotification] = []

    func mapScreenViewModel() -> MapScreenViewModel {
        return MapScreenViewModel(geotifications: geotifications)
    }

    func addGeotification(coordinate: CLLocationCoordinate2D, radius: Double, id: String) {
        let geotification = Geotification(coordinate: coordinate, radius: CLLocationDistance(floatLiteral: radius), id: id)
        geotifications.append(geotification)
    }
}
