//
//  UserServicesStub.swift
//  ViperSampleTests
//
//  Created by MBA0265P on 4/19/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import Foundation

@testable import ViperSample

final class SuccessUserServicesStub: UserServices {
    
    func login(email: String, password: String, completion: @escaping (Result<UserEntity>) -> ()) {
        let entity = UserEntity(email: "abc@gmail.com", name: "Luffy Monkey D.")
        completion(.success(entity))
    }
}
