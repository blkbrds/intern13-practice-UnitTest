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

final class HomePresenterTests: QuickSpec {

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

            it("Element of 'fruits' array should be instance of 'Fruit'") {
                expect(mockHomeVC.fruits.first).to(beAnInstanceOf(Fruit.self))
                expect(mockHomeVC.fruits.last).to(beAnInstanceOf(Fruit.self))
            }

            it("Test first element of 'fruits' array") {
                expect(mockHomeVC.fruits.first?.name) == "apple"
                expect(mockHomeVC.fruits.first?.price) == 125
            }
        }

        describe("Test function 'showError()' ") {
            beforeEach {
                homePresenter.showError(error: Dummy.error)
            }

            it("Error should be pass to class implement") {
                expect(mockDefautHR.error?._code) == 444
                expect(mockDefautHR.error?._domain) == "https://ExampleError"
            }
        }

        describe("Test function 'viewDidLoad()' ") {
            beforeEach {
                homePresenter.viewDidLoad()
            }

            it("Number of element 'fruits' array should be 5") {
                expect(mockHomeVC.fruits.count) == 5
            }
            
            it("Element of 'fruits' array should be instance of 'Fruit'") {
                expect(mockHomeVC.fruits[0]).to(beAnInstanceOf(Fruit.self))
                expect(mockHomeVC.fruits[1]).to(beAnInstanceOf(Fruit.self))
                expect(mockHomeVC.fruits[2]).to(beAnInstanceOf(Fruit.self))
                expect(mockHomeVC.fruits[3]).to(beAnInstanceOf(Fruit.self))
                expect(mockHomeVC.fruits[4]).to(beAnInstanceOf(Fruit.self))
            }
            
            it("Test first element of 'fruits' array") {
                expect(mockHomeVC.fruits.first?.name) == "Banana"
                expect(mockHomeVC.fruits.first?.price) == 1.5
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
