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
    
    var value: Value? {
        switch self {
        case .success(let value):
            return value
        case .failure:
            return nil
        }
    }
    
    var error: Error? {
        switch self {
        case .success:
            return nil
        case .failure(let error):
            return error
        }
    }
}

typealias Completion<Value> = (Result<Value>) -> Void
