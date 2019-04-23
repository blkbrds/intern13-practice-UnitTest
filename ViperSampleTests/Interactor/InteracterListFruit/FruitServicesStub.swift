//
//  FruitServicesStub.swift
//  ViperSampleTests
//
//  Created by MBA0144 on 4/22/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import Foundation
@testable import ViperSample

final class SuccessFruitServicesStub: FruitServices {
    func getFruits(completion: @escaping Completion<[FruitEntity]>) {
        completion(.success([FruitEntity(name: "test", price: 123)]))
    }
}

