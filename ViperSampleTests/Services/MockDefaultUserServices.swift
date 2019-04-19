//
//  MockDefaultUserServices.swift
//  ViperSampleTests
//
//  Created by MBA0023 on 4/19/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import Foundation

@testable import ViperSample

final class MockDefaultUserServices: UserServices {

    func login(email: String, password: String, completion: @escaping (Result<UserEntity>) -> ()) {
        if !email.isValidEmail() {
            completion(.failure(Errors.invalidEmail))
            return
        }
        guard email == "abc@gmail.com" && password == "123456" else {
            completion(.failure(Errors.loginFail))
            return
        }
        let entity = UserEntity(email: "abc@gmail.com", name: "Anna")
        completion(.success(entity))
    }
}
