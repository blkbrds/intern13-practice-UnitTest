//
//  Result.swift
//  DemoViper
//
//  Created by Van Le H. on 4/2/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import Foundation

enum Result<Value> {
    case success(Value)
    case failure(Error)
}

typealias Completion<Value> = (Result<Value>) -> Void
