//
//  FoodInteractor.swift
//  DemoViper
//
//  Created by Van Le H. on 3/29/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import Foundation

protocol ListFruitInteractor {
    var output: ListFruitInteractorOutput? { get set }
    func getFruits()
}

protocol ListFruitInteractorOutput: class {
    func didFetchFruit(result: Result<[Fruit]>)
}

final class DefaultListFruitInteractor: ListFruitInteractor {
    
    private let fruitServices: FruitServices?
    weak var output: ListFruitInteractorOutput?
    
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
