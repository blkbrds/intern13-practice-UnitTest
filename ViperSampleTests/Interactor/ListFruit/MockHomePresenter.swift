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
    
    var result: Result<[Fruit]> = .success([])

    func didFetchFruit(result: Result<[Fruit]>) {
        self.result = result
    }
}
