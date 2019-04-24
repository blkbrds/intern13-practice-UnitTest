//
//  MockHomeRouter.swift
//  ViperSampleTests
//
//  Created by MBA0265P on 4/23/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import Foundation

@testable import ViperSample

final class MockDefaultHomeRouter: HomeRouter {
    
    var error: Error?
    
    func showError(error: Error) {
        self.error = error
    }
}
