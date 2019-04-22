//
//  MockLoginInteractorOutput.swift
//  ViperSampleTests
//
//  Created by MBA0265P on 4/19/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import Foundation

@testable import ViperSample

final class MockLoginInteractorOutput: LoginInteractorOutput {
    
    var result: Result<User> = .success(User())
    
    func didLogin(result: Result<User>) {
        self.result = result
    }
}
