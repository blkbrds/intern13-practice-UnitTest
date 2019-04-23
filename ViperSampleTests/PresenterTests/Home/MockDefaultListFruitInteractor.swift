//
//  MockListFruitInteractor.swift
//  ViperSampleTests
//
//  Created by MBA0265P on 4/23/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import Foundation

@testable import ViperSample

final class MockDefaultListFruitInteractor: ListFruitInteractor {
    
    var output: ListFruitInteractorOutput?
    var isPassValue = false
    
    func getFruits() {
        isPassValue = true
    }
}
