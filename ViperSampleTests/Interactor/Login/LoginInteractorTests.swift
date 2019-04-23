//
//  LoginInteractorTests.swift
//  ViperSampleTests
//
//  Created by MBA0010 on 4/19/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import Quick
import Nimble

@testable import ViperSample

class LoginInteractorTests: QuickSpec {

    override func spec() {

        var loginInteractor: LoginInteractor!
        var mockLP: MockLoginPresenter!

        beforeEach {
            loginInteractor = DefaultLoginInteractor(userServices: DefaultUserServices())
            mockLP = MockLoginPresenter()
            loginInteractor.output = mockLP
        }

        describe("Test function 'login()' ") {

            context("When completion success") {

                it("Email should be return 'abc@gmail.com' and 'name' should be return 'Anna' ") {
                    loginInteractor.login(email: "abc@gmail.com", password: "123456")

                    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                        expect(mockLP.user).to(beAnInstanceOf(User.self))
                        expect(mockLP.user?.email) == "abc@gmail.com"
                        expect(mockLP.user?.name) == "Annassdfs"
                    })
                }
            }

            context("When completion failure") {

                it("Email should be return 'abc@gmail.com' and 'name' should be return 'Anna' ") {
                    loginInteractor.login(email: "invalid@gmail.com", password: "invalid_password")

                    expect((mockLP.error as NSError?)?.code) == 1
                    expect((mockLP.error as NSError?)?.domain) == ""
                    expect((mockLP.error as NSError?)?.localizedDescription) == "Login Fail"
                }
            }
        }

        afterEach {
            loginInteractor = nil
            mockLP = nil
        }
    }
}
