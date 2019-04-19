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
        var userServices: DefaultUserServices!
        var mockLoginPresenter: MockLoginPresenter!

        describe("Test LoginInteractor") {

            context("Test LoginInteractor's functions") {

                beforeEach {
                    userServices = DefaultUserServices()
                    loginInteractor = DefaultLoginInteractor(userServices: userServices)
                    mockLoginPresenter = MockLoginPresenter()
                    loginInteractor.output = mockLoginPresenter
                }

                it("Test should be return name and email") {
                    loginInteractor.login(email: "abc@gmail.com", password: "123456")
                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                        expect(mockLoginPresenter.name) == "Anna"
                        expect(mockLoginPresenter.email) == "abc@gmail.com"
                    }
                }

                it("Test should be return invalid email") {
                    loginInteractor.login(email: "aaaa", password: "123")
                    expect(mockLoginPresenter.errorLocalizedDescription) == "Invalid email!"
                }

                it("Test should be return faild login") {
                    loginInteractor.login(email: "aaaa@gmail.com", password: "123")
                    expect(mockLoginPresenter.errorLocalizedDescription) == "Login Fail"
                }
            }
        }
    }
}
