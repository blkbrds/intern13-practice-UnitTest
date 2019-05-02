//
//  MockDefaultLoginInteractor.swift
//  ViperSampleTests
//
//  Created by MBA0010 on 4/19/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import Foundation

@testable import ViperSample

final class MockDefaultLoginInteractor: LoginInteractor {

    var output: LoginInteractorOutput?
    var email = ""
    var password = ""

    func login(email: String, password: String) {
        self.email = email
        self.password = password
    }
}
