//
//  FruitServicesStub.swift
//  ViperSampleTests
//
//  Created by MBA0144 on 4/22/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import Foundation
@testable import ViperSample

enum Errorr: Error {
    case error
}

final class SuccessFruitServicesStub: FruitServices {
    func getFruits(completion: @escaping (Result<Array<FruitEntity>>) -> ()) {
        completion(.success([FruitEntity(name: "test", price: 123)]))
    }
}

final class FailureFruitServicesStub: FruitServices {
    func getFruits(completion: @escaping (Result<Array<FruitEntity>>) -> ()) {
        completion(.failure(Errorr.error))
    }
}

