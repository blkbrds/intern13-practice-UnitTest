//
//  FruitServicesTests.swift
//  ViperSampleTests
//
//  Created by MBA0265P on 4/22/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import XCTest
import Quick
import Nimble
import OHHTTPStubs

@testable import ViperSample

final class FruitServicesTests: QuickSpec {
    
    override func spec() {
        
        var validFruitServicesStub: ValidFruitServicesStub!
        
        describe("Test protocol 'FruitServices'") {
            
            beforeEach {
                validFruitServicesStub = ValidFruitServicesStub()
            }
            
            context("When implement it's") {
                
                it("Should be completion result of protocol") {
                    validFruitServicesStub.getFruits(completion: { (result) in
                        switch result {
                        case .success(let value):
                            expect(value.count) == 2
                            expect(value[0].name) == "Boa Hancook"
                            expect(value[1].price) == 475.2
                        case .failure:
                            fail()
                        }
                    })
                }
            }
        }
    }
}
