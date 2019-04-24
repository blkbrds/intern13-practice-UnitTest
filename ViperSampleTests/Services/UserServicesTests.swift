//
//  UserServicesTests.swift
//  ViperSampleTests
//
//  Created by MBA0010 on 4/23/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import Nimble
import Quick
@testable import ViperSample

final class UserServiceTests: QuickSpec {

    override func spec() {

        var userService: UserServices!

        beforeEach {
            userService = DefaultUserServices()
        }

        describe("Test function 'login'") {

            it("Response should be return success") {
                waitUntil(timeout: 10, action: { done in
                    userService?.login(email: "abc@gmail.com", password: "123456", completion: { result in
                        switch result {
                        case .success(let value):
                            expect(value.email) == "abc@gmail.com"
                            expect(value.name) == "Anna"
                        case .failure:
                            fail()
                        }
                        done()
                    })
                })
            }

            it("Response should be return failure with error: 'Invalid email' ") {
                waitUntil(timeout: 10, action: { done in
                    userService?.login(email: "abcxyz", password: "123", completion: { result in
                        switch result {
                        case .success:
                            fail()
                        case .failure(let error):
                            expect((error as NSError?)?.code) == 0
                            expect((error as NSError?)?.domain) == ""
                            expect((error as NSError?)?.localizedDescription) == "Invalid email!"
                        }
                        done()
                    })
                })
            }

            it("Response should be return failure with error: 'Login Fail' ") {
                waitUntil(timeout: 10, action: { done in
                    userService?.login(email: "abcxyz@gmail.com", password: "123", completion: { result in
                        switch result {
                        case .success:
                            fail()
                        case .failure(let error):
                            expect((error as NSError?)?.code) == 1
                            expect((error as NSError?)?.domain) == ""
                            expect((error as NSError?)?.localizedDescription) == "Login Fail"
                        }
                        done()
                    })
                })
            }
        }
        
        afterEach {
            userService = nil
        }
    }
}
