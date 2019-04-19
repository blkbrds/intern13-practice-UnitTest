//
//  MockDefaultListFruitInteractor.swift
//  ViperSampleTests
//
//  Created by MBA0265P on 4/18/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import Foundation

@testable import ViperSample

final class SuccessFruitServicesStub: FruitServices {
    func getFruits(completion: @escaping (Result<Array<FruitEntity>>) -> ()) {
        let fruits = [FruitEntity(name: "Fruit 1", price: 1.5), FruitEntity(name: "Fruit 2", price: 2.0)]
        completion(.success(fruits))
    }
}
