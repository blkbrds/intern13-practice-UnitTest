//
//  User.swift
//  DemoViper
//
//  Created by Van Le H. on 4/1/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import Foundation

struct User {
    var email: String = ""
    var name: String = ""

    init() { }
    
    init(entity: UserEntity) {
        email = entity.email
        name = entity.name
    }
}
