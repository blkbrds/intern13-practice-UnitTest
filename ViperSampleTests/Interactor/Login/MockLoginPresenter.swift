//
//  MockLoginPresenter.swift
//  ViperSampleTests
//
//  Created by MBA0010 on 4/19/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import Foundation

@testable import ViperSample

final class MockLoginPresenter: LoginInteractorOutput {
    
    var user: User?
    var error: Error?

    func didLogin(result: Result<User>) {
        switch result {
        case .success(let user):
            self.user = user
        case .failure(let error):
            self.error = error
        }
    }
}
