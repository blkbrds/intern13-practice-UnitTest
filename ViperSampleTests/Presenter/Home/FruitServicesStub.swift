//
//  FruitServicesStub.swift
//  ViperSampleTests
//
//  Created by MBA0023 on 4/22/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import Foundation

@testable import ViperSample

final class SuccessGetFruits: FruitServices {

    func getFruits(completion: @escaping (Result<Array<FruitEntity>>) -> ()) {
        let fruits = [FruitEntity(name: "Banana", price: 1.5), FruitEntity(name: "Lemon", price: 3.0), FruitEntity(name: "Strawberry", price: 2.5), FruitEntity(name: "Pear", price: 1.8), FruitEntity(name: "Orange", price: 3.5)]
        completion(.success(fruits))
    }
}
