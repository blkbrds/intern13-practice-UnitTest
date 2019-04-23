//
//  FruitServicesStub.swift
//  ViperSampleTests
//
//  Created by MBA0010 on 4/19/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import Foundation

@testable import ViperSample

final class SuccessFruitServiceStub: FruitServices {
    
    func getFruits(completion: @escaping Completion<[FruitEntity]>){
        completion(.success(Dummy.fruits))
    }
}

extension SuccessFruitServiceStub {
    
    struct Dummy {
        static let fruits = [FruitEntity(name: "WaterMelon", price: 15), FruitEntity(name: "StarFruit", price: 300)]
        static let error = NSError(domain: "https://404Error", code: 404, userInfo: nil)
    }
}
