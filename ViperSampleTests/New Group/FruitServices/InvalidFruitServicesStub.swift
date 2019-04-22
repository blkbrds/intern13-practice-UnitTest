//
//  FailureFruitServicesStub.swift
//  ViperSampleTests
//
//  Created by MBA0265P on 4/22/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import Foundation

@testable import ViperSample

final class InvalidFruitServicesStub: FruitServices {
    func getFruits(completion: @escaping (Result<Array<FruitEntity>>) -> ()) {
        let fruits = [FruitEntity]()
        completion(.failure(Errors.invalidValue))
    }
}
