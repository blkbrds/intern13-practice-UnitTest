//
//  MockDefaultLoginRouter.swift
//  ViperSampleTests
//
//  Created by MBA0010 on 4/19/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import Foundation

@testable import ViperSample

final class MockDefaultLoginRouter: LoginRouter {

    var showHomeSCreenFlag = false
    var error: Error?
    
    func showHomeScreen() {
        showHomeSCreenFlag = true
    }

    func showError(error: Error) {
        self.error = error
    }
}
