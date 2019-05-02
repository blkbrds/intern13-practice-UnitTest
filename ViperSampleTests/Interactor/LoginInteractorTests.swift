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
        var defaultLoginInteractor: DefaultLoginInteractor!
        var mockLoginPresenter: MockLoginPresenter!

        describe("Test LoginInteractor") {

            context("Test LoginInteractor's functions") {

                beforeEach {
                    let userServiceStub = SuccessUserServiceStub()
                    defaultLoginInteractor = DefaultLoginInteractor(userServices: userServiceStub)
                    mockLoginPresenter = MockLoginPresenter()
                    defaultLoginInteractor.output = mockLoginPresenter
                }

                it("Test should be return name and email") {
                    defaultLoginInteractor.login(email: "abc@gmail.com", password: "123456")
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
                    let userServiceStub = InvalidEmailUserServiceStub()
                    defaultLoginInteractor = DefaultLoginInteractor(userServices: userServiceStub)
                    mockLoginPresenter = MockLoginPresenter()
                    defaultLoginInteractor.output = mockLoginPresenter
                }

                it("Test should be return invalid email") {
                    defaultLoginInteractor.login(email: "abcgmail.com", password: "123456")
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
                    let userServiceStub = LoginFailUserServiceStub()
                    defaultLoginInteractor = DefaultLoginInteractor(userServices: userServiceStub)
                    mockLoginPresenter = MockLoginPresenter()
                    defaultLoginInteractor.output = mockLoginPresenter
                }

                it("Test should be return faild login") {
                    defaultLoginInteractor.login(email: "abc@gmail.com", password: "12345666")
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
