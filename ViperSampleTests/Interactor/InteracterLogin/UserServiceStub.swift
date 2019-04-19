//
//  UserServiceStub.swift
//  ViperSampleTests
//
//  Created by MBA0144 on 4/19/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import Foundation
@testable import ViperSample

final class SuccessUserServiceStub: UserServices {
    func login(email: String, password: String, completion: @escaping (Result<UserEntity>) -> ()) {
        completion(.success([]))
    }
}


