//
//  LoginInteractorTests.swift
//  ViperSampleTests
//
//  Created by MBA0144 on 4/19/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import Nimble
import Quick
import OHHTTPStubs
@testable import ViperSample

final class LoginInteractorTests: QuickSpec {

    override func spec() {

        var loginInteractor: DefaultLoginInteractor?
        var loginPresenter: MockLoginPresenter?
        var userServiceStub: UserServiceStub?

        describe("Login interactor test") {

            context("Test login func", {

                beforeEach {
                    userServiceStub = UserServiceStub()
                    loginInteractor = DefaultLoginInteractor(userServices: userServiceStub)
                    loginPresenter = MockLoginPresenter()
                    loginInteractor?.output = loginPresenter
                }

                it("Response should be return success", closure: {
                    loginInteractor?.login(email: "abc@gmail.com", password: "123456")
                    expect(loginPresenter?.user?.email) == "abc@gmail.com"
                    expect(loginPresenter?.user?.name) == "Anna"
                })

                it("Response should be return failure  nvalid email", closure: {
                    loginInteractor?.login(email: "xxx", password: "123456")
                    expect(loginPresenter?.err?.localizedDescription) == "Invalid email!"
                })

                it("Response should be return failure login Fail", closure: {
                    loginInteractor?.login(email: "abc@gmail.com", password: "xxx")
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
