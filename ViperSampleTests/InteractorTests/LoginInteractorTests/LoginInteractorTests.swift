//
//  LoginInteractorTests.swift
//  ViperSampleTests
//
//  Created by MBA0265P on 4/19/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import XCTest
import Quick
import Nimble
import OHHTTPStubs

@testable import ViperSample

final class LoginInteractorTests: QuickSpec {
    
    override func spec() {
        
        var defaultLoginInteractor: DefaultLoginInteractor!
        var mockLoginInteractorOutput: MockLoginInteractorOutput!
        var successUserServicesStub: SuccessUserServicesStub!
        var failureUserServicesStub: FailureUserServicesStub!
        var invalidUserServicesStub: InvalidUserServicesStub!
        
        describe("Test method 'login'") {
            
            beforeEach {
                successUserServicesStub = SuccessUserServicesStub()
                mockLoginInteractorOutput = MockLoginInteractorOutput()
                defaultLoginInteractor = DefaultLoginInteractor(userServices: successUserServicesStub)
                defaultLoginInteractor.output = mockLoginInteractorOutput
            }
            
            context("When value return is valid") {
                
                it("Should have been show state of login") {
                    defaultLoginInteractor.login(email: "abc@gmail.com", password: "123456")
                    switch mockLoginInteractorOutput.result {
                    case .success(let value):
                        expect(value.email) == "abc@gmail.com"
                        expect(value.name) == "Luffy Monkey D."
                    case .failure:
                        fail()
                    }
                }
            }
            
            afterEach {
                defaultLoginInteractor = nil
            }
        }
        
        describe("Test method login") {
            
            beforeEach {
                failureUserServicesStub = FailureUserServicesStub()
                mockLoginInteractorOutput = MockLoginInteractorOutput()
                defaultLoginInteractor = DefaultLoginInteractor(userServices: failureUserServicesStub)
                defaultLoginInteractor.output = mockLoginInteractorOutput
            }
            
            context("When format email is wrong") {
                
                it("Shoule be return error email in invalid") {
                    defaultLoginInteractor.login(email: "abc@gmai.com", password: "123456")
                    switch mockLoginInteractorOutput.result {
                    case .success:
                        fail()
                    case .failure(let error):
                        expect(error.localizedDescription) == "Invalid email!"
                    }
                }
            }
        }
        
        describe("Test method login") {
            
            beforeEach {
                invalidUserServicesStub = InvalidUserServicesStub()
                mockLoginInteractorOutput = MockLoginInteractorOutput()
                defaultLoginInteractor = DefaultLoginInteractor(userServices: invalidUserServicesStub)
                defaultLoginInteractor.output = mockLoginInteractorOutput
            }
            
            context("When format email is wrong") {
                
                it("Shoule be return error email in invalid") {
                    defaultLoginInteractor.login(email: "abc@gmai.com", password: "123456")
                    switch mockLoginInteractorOutput.result {
                    case .success:
                        fail()
                    case .failure(let error):
                        expect(error.localizedDescription) == "Login Fail"
                    }
                }
            }
        }
        
        afterSuite {
            defaultLoginInteractor = nil
        }
    }
}
