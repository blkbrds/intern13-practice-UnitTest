//
//  LocationCell.swift
//  BaiTap2NangCao
//
//  Created by MBA0023 on 5/6/19.
//  Copyright © 2019 MBA0023. All rights reserved.
//

import UIKit

final class LocationCell: UITableViewCell {

    @IBOutlet private weak var thumbnailImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var latlongLabel: UILabel!

    var viewModel: LocationCellViewModel? {
        didSet {
            updateView()
        }
    }

    func updateView() {
        nameLabel.text = viewModel?.name
        guard let lat = viewModel?.latlong?.latitude, let long = viewModel?.latlong?.longitude else { return }
        let latDouble = Double(lat)
        let longDouble = Double(long)
        let latText = String(longDouble)
        let longText = String(latDouble)
        latlongLabel.text = "Lat: " + latText + ", Long: " + longText
    }
}
