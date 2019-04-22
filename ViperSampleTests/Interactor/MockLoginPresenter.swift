//
//  MockLoginPresenter.swift
//  ViperSampleTests
//
//  Created by MBA0023 on 4/19/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import Foundation

@testable import ViperSample

final class MockLoginPresenter: LoginInteractorOutput {

    var result: Result<User> = .success(User())

    func didLogin(result: Result<User>) {
        self.result = result
    }
}
