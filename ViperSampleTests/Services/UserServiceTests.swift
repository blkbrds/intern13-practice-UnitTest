//
//  UserServiceTests.swift
//  ViperSampleTests
//
//  Created by MBA0144 on 4/23/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import Nimble
import Quick
@testable import ViperSample

final class UserServiceTests: QuickSpec {

    override func spec() {

        var userService: UserServices?

        describe("User services test") {

            context("Test result of login func", {

                beforeEach {
                    userService = DefaultUserServices()
                }

                it("Response should be return success", closure: {
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
                })

                it("Response should be return failure with error: Invalid email!", closure: {
                    waitUntil(timeout: 10, action: { done in
                        userService?.login(email: "xxx", password: "1234", completion: { result in
                            switch result {
                            case .success:
                                fail()
                            case .failure(let error):
                                expect(error.localizedDescription) == "Invalid email!"
                            }
                            done()
                        })
                    })
                })

                it("Response should be return failure with error: Login Fail", closure: {
                    waitUntil(timeout: 10, action: { done in
                        userService?.login(email: "xxx@gmail.com", password: "1234", completion: { result in
                            switch result {
                            case .success:
                                fail()
                            case .failure(let error):
                                expect(error.localizedDescription) == "Login Fail"
                            }
                            done()
                        })
                    })
                })

                afterEach {
                    userService = nil
                }
            })
        }
    }
}
