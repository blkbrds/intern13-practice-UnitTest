//
//  LoginInteractorTests.swift
//  ViperSampleTests
//
//  Created by MBA0023 on 4/19/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import Quick
import Nimble

@testable import ViperSample

final class LoginInteractorTests: QuickSpec {

    override func spec() {
        var loginInteractor: DefaultLoginInteractor!
        var successUserServices: SuccessUserServiceStub!
        var invalidEmailUserServices: InvalidEmailUserServiceStub!
        var loginFailUserServices: LoginFailUserServiceStub!
        var mockLoginPresenter: MockLoginPresenter!

        describe("Test LoginInteractor") {

            context("Test LoginInteractor's functions") {

                beforeEach {
                    successUserServices = SuccessUserServiceStub()
                    loginInteractor = DefaultLoginInteractor(userServices: successUserServices)
                    mockLoginPresenter = MockLoginPresenter()
                    loginInteractor.output = mockLoginPresenter
                }

                it("Test should be return name and email") {
                    loginInteractor.login(email: "abc@gmail.com", password: "123456")
                    switch mockLoginPresenter.result {
                    case .success(let value):
                        expect(value.email) == "abc@gmail.com"
                        expect(value.name) == "Anna"
                    case .failure:
                        fail()
                    }
                }
            }

            context("Test login fail with valid email") {

                beforeEach {
                    invalidEmailUserServices = InvalidEmailUserServiceStub()
                    loginInteractor = DefaultLoginInteractor(userServices: invalidEmailUserServices)
                    mockLoginPresenter = MockLoginPresenter()
                    loginInteractor.output = mockLoginPresenter
                }

                it("Test should be return invalid email") {
                    loginInteractor.login(email: "abcgmail.com", password: "123456")
                    switch mockLoginPresenter.result {
                    case .success:
                        fail()
                    case .failure(let error):
                        expect(error.localizedDescription) == "Invalid email!"
                    }
                }
            }

            context("Test login fail with wrong email or password") {

                beforeEach {
                    loginFailUserServices = LoginFailUserServiceStub()
                    loginInteractor = DefaultLoginInteractor(userServices: loginFailUserServices)
                    mockLoginPresenter = MockLoginPresenter()
                    loginInteractor.output = mockLoginPresenter
                }

                it("Test should be return faild login") {
                    loginInteractor.login(email: "abc@gmail.com", password: "12345666")
                    switch mockLoginPresenter.result {
                    case .success:
                        fail()
                    case .failure(let error):
                        expect(error.localizedDescription) == "Login Fail"
                    }
                }
            }
        }
    }
}
