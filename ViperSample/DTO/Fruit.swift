//
//  Food.swift
//  DemoViper
//
//  Created by Van Le H. on 4/1/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import Foundation

struct Fruit {
    let name: String
    let price: Double

    init(entity: FruitEntity) {
        name = entity.name
        price = entity.price
    }
}
