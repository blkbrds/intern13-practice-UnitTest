//
//  UserServicesTests.swift
//  ViperSampleTests
//
//  Created by MBA0023 on 4/19/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import Quick
import Nimble

@testable import ViperSample

final class UserServicesTests: QuickSpec {

    override func spec() {
        var defaultUserServices: DefaultUserServices!

        describe("Test UserServices") {

            context("Test UserServices's functions") {

                beforeEach {
                    defaultUserServices = DefaultUserServices()
                }

                it("Test should be return invalid email") {
                    defaultUserServices.login(email: "ads", password: "123", completion: { (result) in
                        switch result {
                        case .success:
                            fail()
                        case .failure(let error):
                            expect(error.localizedDescription) == "Invalid email!"
                        }
                    })
                }

                it("Test login success") {
                    defaultUserServices.login(email: "abc@gmail.com", password: "123456", completion: { (result) in
                        switch result {
                        case .success(let value):
                            expect(value.email) == "abc@gmail.com"
                            expect(value.name) == "Anna"
                        case .failure:
                            fail()
                        }
                    })
                }

                it("Test should be return login fail") {
                    defaultUserServices.login(email: "abdddddc@gmail.com", password: "1234", completion: { (result) in
                        switch result {
                        case .success:
                            fail()
                        case .failure(let error):
                            expect(error.localizedDescription) == "Login Fail"
                        }
                    })
                }
            }
        }
    }
}
