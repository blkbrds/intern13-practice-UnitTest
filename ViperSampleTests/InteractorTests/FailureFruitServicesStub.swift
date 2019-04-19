//
//  MockFruitServicesFailure.swift
//  ViperSampleTests
//
//  Created by MBA0265P on 4/19/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import Foundation

@testable import ViperSample

final class FailureFruitServicesStub: FruitServices {
    func getFruits(completion: @escaping (Result<Array<FruitEntity>>) -> ()) {
        completion(.failure(Errors.invalidValue))
    }
}
