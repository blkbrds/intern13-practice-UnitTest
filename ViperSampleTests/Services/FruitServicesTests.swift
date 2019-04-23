//
//  FruitServicesTests.swift
//  ViperSampleTests
//
//  Created by MBA0023 on 4/23/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import Quick
import Nimble

@testable import ViperSample

final class FruitServicesTests: QuickSpec {

    override func spec() {
        var services: DefaultFruitServices!

        describe("Test FruitServices") {

            context("Test FruitServices's functions") {

                beforeEach {
                    services = DefaultFruitServices()
                }

                it("Test should be return an array of fruit") {
                    services.getFruits(completion: { (result) in
                        switch result {
                        case .success(let value):
                            expect(value.first?.name) == "Banana"
                            expect(value.first?.price) == 1.5
                        case .failure:
                            fail()
                        }
                    })
                }
            }
        }
    }
}

