//
//  MockHomePresenter.swift
//  ViperSampleTests
//
//  Created by MBA0010 on 4/19/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import Foundation

@testable import ViperSample

final class MockHomePresenter: ListFruitInteractorOutput {
    
    var fruits: [Fruit] = []
    var error: Error?

    func didFetchFruit(result: Result<[Fruit]>) {
        switch result {
        case .success(let fruits):
            self.fruits = fruits
        case .failure(let error):
            self.error = error
        }
    }
}
