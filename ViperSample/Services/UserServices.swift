//
//  UserServices.swift
//  DemoViper
//
//  Created by Van Le H. on 3/29/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import Foundation

protocol UserServices {
    func login(email: String, password: String, completion: @escaping Completion<UserEntity>)
}

final class DefaultUserServices: UserServices {
    func login(email: String, password: String, completion: @escaping Completion<UserEntity>) {
        if !email.isValidEmail() {
            completion(.failure(Errors.invalidEmail))
            return
        }
        
        guard email == "abc@gmail.com" && password == "123456" else {
            completion(.failure(Errors.loginFail))
            return
        }
    
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            let entity = UserEntity(email: "abc@gmail.com", name: "Anna")
            completion(.success(entity))
        }
    }
}
