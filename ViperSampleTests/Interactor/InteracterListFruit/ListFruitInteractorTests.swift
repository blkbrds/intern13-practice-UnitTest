//
//  ListFruitInteractorTests.swift
//  ViperSampleTests
//
//  Created by MBA0144 on 4/22/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import Nimble
import Quick
@testable import ViperSample

final class ListFruitInteractorTests: QuickSpec {

    override func spec() {

        var listFruitInteractor: DefaultListFruitInteractor?
        var homePresenter: MockHomePresenter?

        describe("List Fruit Interacter test") {

            context("getFruits should be return success", {

                beforeEach {
                    let fruitServiceStub = SuccessFruitServicesStub()
                    listFruitInteractor = DefaultListFruitInteractor(fruitServices: fruitServiceStub)
                    homePresenter = MockHomePresenter()
                    listFruitInteractor?.output = homePresenter
                }

                it("getFruits should be return success", closure: {
                    listFruitInteractor?.getFruits()
                    expect(homePresenter?.fruit.isEmpty) == false
                    expect(homePresenter?.fruit.first?.name) == "test"
                    expect(homePresenter?.fruit.first?.price) == 123
                    expect(homePresenter?.error).to(beNil())
                })

                afterEach {
                    listFruitInteractor = nil
                    homePresenter = nil
                }
            })
        }
    }
}
