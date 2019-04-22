//
//  MockDefaultListFruitInteractor.swift
//  ViperSampleTests
//
//  Created by MBA0023 on 4/22/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import Foundation

@testable import ViperSample

final class MockDefaultListFruitInteractor: ListFruitInteractor {
    
    var output: ListFruitInteractorOutput?
    var check = false

    func getFruits() {
        check = true
    }
}
