//
//  MockListFruitInteractorOutput.swift
//  ViperSampleTests
//
//  Created by MBA0010 on 4/18/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import Foundation
@testable import ViperSample

final class MockDefaultListFruitInteractor: ListFruitInteractor {
    
    var output: ListFruitInteractorOutput?
    var flag = false
    
    func getFruits() {
        flag = true
    }
    
    func passSuccess() {
        output?.didFetchFruit(result: .success(Dummy.fruits))
    }
    
    func passFailure() {
        output?.didFetchFruit(result: .failure(Dummy.error))
    }
}

extension MockDefaultListFruitInteractor {
    
    struct Dummy {
        static let fruits: [Fruit] = {
            let pipeApple = Fruit(entity: FruitEntity(name: "PipeApple", price: 100))
            let lemon = Fruit(entity: FruitEntity(name: "Lemon", price: 110))
            return [pipeApple, lemon]
        }()
        
        static let error = NSError(domain: "https://ExampleError111", code: 400, userInfo: nil)
    }
}
