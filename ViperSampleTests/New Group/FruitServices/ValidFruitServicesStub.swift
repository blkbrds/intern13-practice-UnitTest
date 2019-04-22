//
//  MockFruitServices.swift
//  ViperSampleTests
//
//  Created by MBA0265P on 4/22/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import Foundation

@testable import ViperSample

final class ValidFruitServicesStub: FruitServices {
    func getFruits(completion: @escaping (Result<Array<FruitEntity>>) -> ()) {
        let fruits = [FruitEntity(name: "Boa Hancook", price: 1000.5), FruitEntity(name: "Jimbei", price: 475.2)]
        completion(.success(fruits))
    }
}
