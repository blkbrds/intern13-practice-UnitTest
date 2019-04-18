//
//  HomePresenterTests.swift
//  ViperSampleTests
//
//  Created by MBA0010 on 4/18/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import Nimble
import Quick

@testable import ViperSample

class HomePresenterTests: QuickSpec {

    override func spec() {

        var homePresenter: DefaultHomePresenter!
        var mockHomeVC: MockHomeViewController!
        var mockDefautHR: MockDefaultHomeRouter!
        var mockListFIO: MockDefaultListFruitInteractor!

        beforeEach {
            mockHomeVC = MockHomeViewController()
            mockDefautHR = MockDefaultHomeRouter()
            mockListFIO = MockDefaultListFruitInteractor()
            homePresenter = DefaultHomePresenter(view: mockHomeVC, router: mockDefautHR, fruitInteractor: mockListFIO)
        }

        describe("Test funtion 'updateView()'") {
            beforeEach {
                homePresenter.updateView(fruits: Dummy.fruits)
            }

            it("Number of element 'fruits' array should be 2") {
                expect(mockHomeVC.fruits.count) == 2
            }

            it("Elemet of 'fruits' array should be instance of 'Fruit'") {
                expect(mockHomeVC.fruits.first).to(beAnInstanceOf(Fruit.self))
            }

            it("Test first element of 'fruits' array") {
                guard let fruit = mockHomeVC.fruits.first else { return }
                expect(fruit.name) == "apple"
                expect(fruit.price) == 125
            }
        }

        describe("Test function 'showError()' ") {
            beforeEach {
                homePresenter.showError(error: Dummy.error)
            }

            it("Error should be pass to class implement") {
                guard let error = mockDefautHR.error as NSError? else { return }
                expect(error.code) == 444
                expect(error.domain) == "https://ExampleError"
            }
        }

        describe("Test function 'viewDidLoad()' ") {
            beforeEach {
                homePresenter.viewDidLoad()
            }

            it("Signal shoud be pass to class implement, 'flag' shoud be true") {
                expect(mockListFIO.flag) == true
            }
        }

        describe("Test function 'didFetchFruit()'") {
            it("When success") {
                mockListFIO.passSuccess()

                expect(mockHomeVC.fruits.count) == 2
                expect(mockHomeVC.fruits.first).to(beAnInstanceOf(Fruit.self))

                guard let fruit = mockHomeVC.fruits.first else { return }
                expect(fruit.name) == "PipeApple"
                expect(fruit.price) == 100
            }
            
            it("When failure") {
                mockListFIO.passFailure()
                
                guard let error = mockDefautHR.error as NSError? else { return }
                expect(error.code) == 400
                expect(error.domain) == "https://ExampleError111"
            }
        }

        afterEach {
            homePresenter = nil
            mockHomeVC = nil
            mockListFIO = nil
            mockDefautHR = nil
        }
    }
}

extension HomePresenterTests {

    struct Dummy {
        static let fruits: [Fruit] = {
            let apple = Fruit(entity: FruitEntity(name: "apple", price: 125))
            let mango = Fruit(entity: FruitEntity(name: "mango", price: 100))
            return [apple, mango]
        }()

        static let error = NSError(domain: "https://ExampleError", code: 444, userInfo: nil)
    }
}
