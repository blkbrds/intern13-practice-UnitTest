//
//  LoginPresenterTests.swift
//  ViperSampleTests
//
//  Created by MBA0023 on 4/19/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import Quick
import Nimble

@testable import ViperSample

final class LoginPresenterTests: QuickSpec {

    override func spec() {
        var loginPresenter: DefaultLoginPresenter!
        var mockLoginRouter: MockDefaultLoginRouter!
        var mockLoginInteractor: MockDefaultLoginInteractor!
        var view: LoginView!
        var error: Error!

        describe("Test LoginPresenter") {

            context("Test LoginPresenter's functions") {

                beforeEach {
                    mockLoginRouter = MockDefaultLoginRouter()
                    mockLoginInteractor = MockDefaultLoginInteractor()
                    loginPresenter = DefaultLoginPresenter(view: view, router: mockLoginRouter, loginInteractor: mockLoginInteractor)
                    error = Dummy.error
                }

                it("Test error should was sent to class implement it") {
                    loginPresenter.showError(error: error)
                    expect(mockLoginRouter.error?._domain) == "trongque"
                }

                it("Test func showHomeScreen is called") {
                    loginPresenter.showHomeScreen()
                    expect(mockLoginRouter.checkFuncShowHomeScreenIsCalled) == true
                }

                it("Test func handleLoginAction() send data to class implement") {
                    loginPresenter.handleLoginAction(email: "abc", password: "123")
                    mockLoginInteractor.login(email: "abc", password: "123")
                    expect(mockLoginInteractor.email) == "abc"
                    expect(mockLoginInteractor.password) == "123"
                }
            }
        }

    }
}

extension LoginPresenterTests {

    struct Dummy {
        static let error = NSError(domain: "trongque", code: 404, userInfo: nil)
    }
}
