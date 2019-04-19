//
//  Errors.swift
//  DemoViper
//
//  Created by Van Le H. on 3/29/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import Foundation

struct Errors {
    static let invalidEmail = NSError(domain: "",
                                      code: 0,
                                      userInfo: [NSLocalizedDescriptionKey: "Invalid email!"])
    
    static let loginFail = NSError(domain: "",
                                   code: 1,
                                   userInfo: [NSLocalizedDescriptionKey: "Login Fail"])
    
    static let invalidValue = NSError(domain: "",
                                      code: 2,
                                      userInfo: [NSLocalizedDescriptionKey: "value is invalid"])
}
