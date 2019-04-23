//
//  LoginPresenterTests.swift
//  ViperSampleTests
//
//  Created by MBA0010 on 4/19/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import Quick
import Nimble

@testable import ViperSample

final class LoginPresenterTests: QuickSpec {

    override func spec() {
        
        var loginPresenter: DefaultLoginPresenter!
        var mockLoginVC: MockLoginViewController!
        var mockDefaltLR: MockDefaultLoginRouter!
        var mockDefaultLI: MockDefaultLoginInteractor!
        
        beforeEach {
            mockLoginVC = MockLoginViewController()
            mockDefaltLR = MockDefaultLoginRouter()
            mockDefaultLI = MockDefaultLoginInteractor()
            loginPresenter = DefaultLoginPresenter(view: mockLoginVC, router: mockDefaltLR, loginInteractor: mockDefaultLI)
        }
        
        describe("Test function 'showHomeScreen()' ") {
            
            beforeEach {
                loginPresenter.showHomeScreen()
            }
            
            it("Signal shoud be pass to class implement, 'showHomeSCreenFlag' shoud be true") {
                expect(mockDefaltLR.showHomeSCreenFlag) == true
            }
        }
        
        describe("Test function 'showError()' ") {
            
            beforeEach {
                loginPresenter.showError(error: Dummy.error)
            }
            
            it("Error should be pass to class implement") {
                expect((mockDefaltLR.error as NSError?)?.code) == 111
                expect((mockDefaltLR.error as NSError?)?.domain) == "https://ExampleError1234"
            }
        }
        
        describe("Test functon 'handleLoginAction()' ") {
            
            beforeEach {
                loginPresenter.handleLoginAction(email: Dummy.email, password: Dummy.password)
            }
            
            it("Email should be return 'huynhtan@gmail.com'") {
                expect(mockDefaultLI.email) == "huynhtan@gmail.com"
            }
            
            it("Password should be return '123456'") {
                expect(mockDefaultLI.password) == "123456"
            }
        }
        
        afterEach {
            mockLoginVC = nil
            mockDefaltLR = nil
            mockDefaultLI = nil
            loginPresenter = nil
        }
    }
}

extension LoginPresenterTests {
    
    struct Dummy {
        static let email = "huynhtan@gmail.com"
        static let password = "123456"
        static let error = NSError(domain: "https://ExampleError1234", code: 111, userInfo: nil)
    }
}
