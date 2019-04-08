//
//  UserEntity.swift
//  DemoViper
//
//  Created by Van Le H. on 3/28/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import Foundation

struct UserEntity {
    let email: String
    let name: String
    
    init(email: String, name: String) {
        self.email = email
        self.name = name
    }
}
