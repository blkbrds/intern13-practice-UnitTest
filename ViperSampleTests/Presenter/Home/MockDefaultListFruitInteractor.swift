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
}
