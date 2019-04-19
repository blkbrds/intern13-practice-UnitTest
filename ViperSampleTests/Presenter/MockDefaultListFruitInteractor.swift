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
    private let fruitServices: FruitServices?
    
    init(fruitServices: FruitServices? = DefaultFruitServices()) {
        self.fruitServices = fruitServices
    }
    
    func getFruits() {
        fruitServices?.getFruits(completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let entities):
                var fruits: [Fruit] = []
                for entity in entities {
                    let fruit = Fruit(entity: entity)
                    fruits.append(fruit)
                }
                self.output?.didFetchFruit(result: .success(fruits))
            case .failure(let error):
                self.output?.didFetchFruit(result: .failure(error))
            }
        })
    }
}
