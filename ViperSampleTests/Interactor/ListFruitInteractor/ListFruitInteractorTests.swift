//
//  ListFruitInteractorTests.swift
//  ViperSampleTests
//
//  Created by MBA0023 on 4/22/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import Quick
import Nimble

@testable import ViperSample

final class ListFruitInteractorTests: QuickSpec {

    override func spec() {
        var listFruitInteractor: DefaultListFruitInteractor!
        var fruitServices: FruitServices!
        var mockHomePresenter: MockHomePresenter!

        describe("Test FruitInteractor") {

            context("Test FruitInteractor's functions") {

                beforeEach {
                    fruitServices = SuccessGetFruits()
                    mockHomePresenter = MockHomePresenter()
                    listFruitInteractor = DefaultListFruitInteractor(fruitServices: fruitServices)
                    listFruitInteractor.output = mockHomePresenter
                }

                it("Test should be return an array of Fruits") {
                    listFruitInteractor.getFruits()
                    switch mockHomePresenter.result {
                    case .success(let value):
                        expect(value.count) == 5
                        expect(value[0].name) == "Banana"
                        expect(value[0].price) == 1.5
                    case .failure:
                        fail()
                    }
                }
            }
        }
    }
}

