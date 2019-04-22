//
//  UserServicesStub.swift
//  ViperSampleTests
//
//  Created by MBA0265P on 4/22/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import Foundation

@testable import ViperSample

final class UserServicesStub: UserServices {
    
    func login(email: String, password: String, completion: @escaping (Result<UserEntity>) -> ()) {
        guard email == "abc@gmail.com" && password == "123456" else {
            completion(.failure(Errors.loginFail))
            return
        }
    }
}
