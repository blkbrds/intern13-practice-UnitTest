//
//  FoodServices.swift
//  DemoViper
//
//  Created by Van Le H. on 3/29/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import Foundation

protocol FruitServices {
    func getFruits(completion: @escaping Completion<[FruitEntity]>)
}

final class DefaultFruitServices: FruitServices {
    func getFruits(completion: @escaping Completion<[FruitEntity]>) {
        let fruits = [FruitEntity(name: "Banana", price: 1.5), FruitEntity(name: "Lemon", price: 3.0), FruitEntity(name: "Strawberry", price: 2.5), FruitEntity(name: "Pear", price: 1.8), FruitEntity(name: "Orange", price: 3.5)]
        completion(.success(fruits))
    }
}
