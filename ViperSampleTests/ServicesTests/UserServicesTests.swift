//
//  UserServicesTests.swift
//  ViperSampleTests
//
//  Created by MBA0265P on 4/23/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import XCTest
import Quick
import Nimble
import OHHTTPStubs

@testable import ViperSample

final class UserServicesTests: QuickSpec {
    
    override func spec() {
        
        var defaultUserServices: DefaultUserServices!
        
        describe("Test protocol 'UserServices'") {
            
            beforeEach {
                defaultUserServices = DefaultUserServices()
            }
            
            context("When implement protocol, func") {
                
                it("Should be return result login fail") {
                    defaultUserServices.login(email: "abc@gmail.com", password: "12345678", completion: { (result) in
                        switch result {
                        case .success:
                            fail()
                        case .failure(let error):
                            expect(error.localizedDescription) == "Login Fail"
                        }
                    })
                }
                
                it("Should be return result invalid email") {
                    defaultUserServices.login(email: "abcgmail.com", password: "12345678", completion: { (result) in
                        switch result {
                        case .success:
                            fail()
                        case .failure(let error):
                            expect(error.localizedDescription) == "Invalid email!"
                        }
                    })
                }
                
                it("Should be return result: email and name") {
                    defaultUserServices.login(email: "abc@gmail.com", password: "123456", completion: { (result) in
                        switch result {
                        case .success(let value):
                            expect(value.name) == "Anna"
                            expect(value.email) == "abc@gmail.com"
                        case .failure:
                            fail()
                        }
                    })
                }
            }
            afterEach {
                defaultUserServices = nil
            }
        }
    }
}
