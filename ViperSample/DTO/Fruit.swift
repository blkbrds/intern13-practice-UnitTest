//
//  Food.swift
//  DemoViper
//
//  Created by Van Le H. on 4/1/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import Foundation

struct Fruit {
    var name = ""
    var price = 0.0
    
    // Init empty for unit test
    init() {}
    
    init(entity: FruitEntity) {
        name = entity.name
        price = entity.price
    }
}
