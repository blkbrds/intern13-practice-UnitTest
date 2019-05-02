//
//  UserServicesStub.swift
//  ViperSampleTests
//
//  Created by MBA0023 on 4/22/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import Foundation

@testable import ViperSample

final class SuccessUserServiceStub: UserServices {
    func login(email: String, password: String, completion: @escaping (Result<UserEntity>) -> ()) {
        completion(.success(UserEntity(email: "abc@gmail.com", name: "Anna")))
    }
}

final class InvalidEmailUserServiceStub: UserServices {
    func login(email: String, password: String, completion: @escaping (Result<UserEntity>) -> ()) {
        completion(.failure(Errors.invalidEmail))
    }
}

final class LoginFailUserServiceStub: UserServices {
    func login(email: String, password: String, completion: @escaping (Result<UserEntity>) -> ()) {
        completion(.failure(Errors.loginFail))
    }
}
