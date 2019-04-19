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

    var name = ""
    var email = ""
    var error: Error?
    var errorLocalizedDescription = ""

    func didLogin(result: Result<User>) {
        switch result {
        case .success(let user):
            name = user.name
            email = user.email
        case .failure(let error):
            self.errorLocalizedDescription = error.localizedDescription
        }
    }
}
