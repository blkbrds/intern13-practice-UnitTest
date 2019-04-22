//
//  UserServicesTests.swift
//  ViperSampleTests
//
//  Created by MBA0265P on 4/22/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import XCTest
import Quick
import Nimble
import OHHTTPStubs

@testable import ViperSample

final class UserServicesTests: QuickSpec {

    override func spec() {
        
        var userServicesStub: UserServicesStub!
        
        describe("Test protocol 'UserServices'") {
            
            beforeEach {
                userServicesStub = UserServicesStub()
            }
            
            context("When implement protocol") {
                
                it("Should be return result of it's") {
                    userServicesStub.login(email: "abcgmail.com", password: "123456", completion: { (result) in
                        switch result {
                        case .success:
                            fail()
                        case .failure(let error):
                            expect(error.localizedDescription) == "Login Fail"
                        }
                    })
                }
            }
            afterEach {
                userServicesStub = nil
            }
        }
    }
}
