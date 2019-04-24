
//
//  MockDefaultLoginInteractor.swift
//  ViperSampleTests
//
//  Created by MBA0265P on 4/23/19.
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
