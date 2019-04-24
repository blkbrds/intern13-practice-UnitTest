//
//  FruitServicesTests.swift
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

final class FruitServicesTests: QuickSpec {
    
    override func spec() {
        
        var defaultFruitServices: DefaultFruitServices!
        
        describe("Test protocol 'FruitServices'") {
            
            beforeEach {
                defaultFruitServices = DefaultFruitServices()
            }
            
            context("When implement it's") {
                
                it("Should be completion result of protocol") {
                    defaultFruitServices.getFruits(completion: { (result) in
                        switch result {
                        case .success(let value):
                            expect(value.count) == 5
                            expect(value[0].name) == "Banana"
                            expect(value[1].price) == 3
                        case .failure:
                            fail()
                        }
                    })
                }
            }
        }
    }
}
