//
//  LoginPresenterTests.swift
//  ViperSampleTests
//
//  Created by MBA0265P on 4/23/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import XCTest
import Quick
import Nimble
import OHHTTPStubs

@testable import ViperSample

final class LoginPresenterTests: QuickSpec {
    
    override func spec() {
        
        var defaultLoginPresenter: DefaultLoginPresenter!
        var mockDefaultLoginRouter: MockDefaultLoginRouter!
        var mockLoginViewController: MockLoginViewController!
        var mockDefaultLoginInteractor: MockDefaultLoginInteractor!
        
        beforeEach {
            mockDefaultLoginRouter = MockDefaultLoginRouter()
            mockLoginViewController = MockLoginViewController()
            mockDefaultLoginInteractor = MockDefaultLoginInteractor()
            defaultLoginPresenter = DefaultLoginPresenter(view: mockLoginViewController, router: mockDefaultLoginRouter, loginInteractor: mockDefaultLoginInteractor)
        }
        
        describe("Test method 'showHomeScreen'") {
            
            context("When func is called") {
                
                it("Should be show home screen") {
                    defaultLoginPresenter.showHomeScreen()
                    expect(mockDefaultLoginRouter.isPush) == true
                }
            }
        }
        
        describe("Test method 'showError'") {
            
            context("When func is called") {
                
                it("Should be display error") {
                    defaultLoginPresenter.showError(error: Dummy.error)
                    expect(mockDefaultLoginRouter.error?.localizedDescription) == "Login fail. Please enter again! Hihihihi"
                }
            }
        }
        
        describe("Test method 'handleLoginAction'") {
            
            context("When func is called") {
                
                it("Should have been login is successed") {
                    defaultLoginPresenter.handleLoginAction(email: "abc@gmail.com", password: "123456")
                    expect(mockDefaultLoginInteractor.email) == "abc@gmail.com"
                    expect(mockDefaultLoginInteractor.password) == "123456"
                }
            }
        }
        
        afterEach {
            defaultLoginPresenter = nil
        }
    }
}

extension LoginPresenterTests {
    
    struct Dummy {
        static let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Login fail. Please enter again! Hihihihi"])
    }
}
