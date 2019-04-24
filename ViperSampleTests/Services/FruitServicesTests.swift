//
//  FruitServicesTests.swift
//  ViperSampleTests
//
//  Created by MBA0010 on 4/23/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import Quick
import Nimble

@testable import ViperSample

final class FruitServicesTests: QuickSpec {

    override func spec() {

        var fruitServices: FruitServices?

        beforeEach {
            fruitServices = DefaultFruitServices()
        }

        describe("Test 'getFruits' function") {

            it("Response should be return success") {
                waitUntil(timeout: 10, action: { done in
                    fruitServices?.getFruits(completion: { result in
                        switch result {
                        case .success(let value):
                            expect(value.isEmpty) == false
                            expect(value.first?.name) == "Banana"
                            expect(value.first?.price) == 1.5
                        case .failure:
                            fail()
                        }
                        done()
                    })
                })
            }
        }
        
        afterEach {
            fruitServices = nil
        }
    }
}
