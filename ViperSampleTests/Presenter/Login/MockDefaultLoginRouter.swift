//
//  MockDefaultLoginRouter.swift
//  ViperSampleTests
//
//  Created by MBA0023 on 4/19/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import Foundation

@testable import ViperSample

final class MockDefaultLoginRouter: LoginRouter {

    var error: Error?
    var checkFuncShowHomeScreenIsCalled = false

    func showHomeScreen() {
        checkFuncShowHomeScreenIsCalled = true
    }

    func showError(error: Error) {
        self.error = error
    }
}
