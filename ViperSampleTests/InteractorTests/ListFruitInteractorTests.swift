//
//  ListFruitInteractorTests.swift
//  ViperSampleTests
//
//  Created by MBA0265P on 4/18/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import XCTest
import Quick
import Nimble
import OHHTTPStubs

@testable import ViperSample

final class ListFruitInteractorTests: QuickSpec {
    
    override func spec() {
        
        var defaultListFruitInteractor: DefaultListFruitInteractor!
        var successFruitServicesStub: SuccessFruitServicesStub!
        var failureFruitServicesStub: FailureFruitServicesStub!
        var mockListFruitInteractorOutput: MockListFruitInteractorOutput!
        
        describe("Test method 'getFruits'") {
            
            beforeEach {
                successFruitServicesStub = SuccessFruitServicesStub()
                defaultListFruitInteractor = DefaultListFruitInteractor(fruitServices: successFruitServicesStub)
                mockListFruitInteractorOutput = MockListFruitInteractorOutput()
                defaultListFruitInteractor.output = mockListFruitInteractorOutput
            }
            
            it("When method 'getFruits' is calling should have been return value valid") {
                expect(defaultListFruitInteractor.getFruits()) == mockListFruitInteractorOutput.didFetchFruit(result: .success([]))
            }
        }
        
        afterEach {
            defaultListFruitInteractor = nil
        }
        
        describe("Test method getFruits when output is failure") {
            
            beforeEach {
                failureFruitServicesStub = FailureFruitServicesStub()
                defaultListFruitInteractor = DefaultListFruitInteractor(fruitServices: failureFruitServicesStub)
                mockListFruitInteractorOutput = MockListFruitInteractorOutput()
                defaultListFruitInteractor.output = mockListFruitInteractorOutput
            }
            
            it("When method 'getFruits' called should be return value nil / error by server") {
                expect(defaultListFruitInteractor.getFruits()) == mockListFruitInteractorOutput.didFetchFruit(result: .failure(Errors.invalidValue))
            }
            
            afterEach {
                defaultListFruitInteractor = nil
            }
        }
    }
}
