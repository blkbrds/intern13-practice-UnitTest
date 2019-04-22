//
//  InvalidUserServicesStub.swift
//  ViperSampleTests
//
//  Created by MBA0265P on 4/22/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import Foundation

@testable import ViperSample

final class InvalidUserServicesStub: UserServices {
    
    func login(email: String, password: String, completion: @escaping (Result<UserEntity>) -> ()) {
        completion(.failure(Errors.loginFail))
    }
}

