//
//  HomeCell.swift
//  DemoViper
//
//  Created by Van Le H. on 3/29/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import UIKit

final class HomeCell: UITableViewCell {

    // MARk: - Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    func updateView(name: String, price: Double) {
        nameLabel.text = name
        priceLabel.text = "\(price)$"
    }
}
