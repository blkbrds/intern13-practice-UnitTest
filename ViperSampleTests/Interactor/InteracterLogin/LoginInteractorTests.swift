//
//  LoginInteractorTests.swift
//  ViperSampleTests
//
//  Created by MBA0144 on 4/19/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import Nimble
import Quick
@testable import ViperSample

final class LoginInteractorTests: QuickSpec {

    override func spec() {

        var loginInteractor: DefaultLoginInteractor?
        var loginPresenter: MockLoginPresenter?

        describe("Login interactor test") {

            context("Response should be return success", {

                beforeEach {
                    let userServiceStub = SuccessUserServiceStub()
                    loginInteractor = DefaultLoginInteractor(userServices: userServiceStub)
                    loginPresenter = MockLoginPresenter()
                    loginInteractor?.output = loginPresenter
                }

                it("Response should be return success", closure: {
                    loginInteractor?.login(email: "abc@gmail.com", password: "123456")
                    expect(loginPresenter?.user?.email) == "abc@gmail.com"
                    expect(loginPresenter?.user?.name) == "abc"
                })

                afterEach {
                    loginInteractor = nil
                    loginPresenter = nil
                }
            })

            context("Response should be return failure with error: Invalid email!", {

                beforeEach {
                    let userServiceStub = InvalidEmailUserServiceStub()
                    loginInteractor = DefaultLoginInteractor(userServices: userServiceStub)
                    loginPresenter = MockLoginPresenter()
                    loginInteractor?.output = loginPresenter
                }

                it("Error should be invalid email", closure: {
                    loginInteractor?.login(email: "abc@gmail.com", password: "123456")
                    expect(loginPresenter?.err?.localizedDescription) == "Invalid email!"
                })

                afterEach {
                    loginInteractor = nil
                    loginPresenter = nil
                }
            })


            context("Response should be return failure with error: Login Fail", {

                beforeEach {
                    let userServiceStub = LoginFailUserServiceStub()
                    loginInteractor = DefaultLoginInteractor(userServices: userServiceStub)
                    loginPresenter = MockLoginPresenter()
                    loginInteractor?.output = loginPresenter
                }

                it("Error should be login fail", closure: {
                    loginInteractor?.login(email: "abc@gmail.com", password: "123456")
                    expect(loginPresenter?.err?.localizedDescription) == "Login Fail"
                })

                afterEach {
                    loginInteractor = nil
                    loginPresenter = nil
                }
            })
        }
    }
}
