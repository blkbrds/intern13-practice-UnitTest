//
//  MockHomePresenter.swift
//  ViperSampleTests
//
//  Created by MBA0144 on 4/22/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import Foundation
@testable import ViperSample

final class MockHomePresenter: ListFruitInteractorOutput {

    var fruit: [Fruit] = []
    var error: Error?

    func didFetchFruit(result: Result<[Fruit]>) {
        switch result {
        case .success(let value):
            self.fruit = value
        case .failure(let error):
            self.error = error
        }
    }
}
