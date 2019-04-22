//
//  HomePresenterTests.swift
//  ViperSampleTests
//
//  Created by MBA0023 on 4/22/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import Quick
import Nimble

@testable import ViperSample

final class HomePresenterTests: QuickSpec {

    override func spec() {
        var homePresenter: DefaultHomePresenter!
        var mockHomeRouter: MockDefaultHomeRouter!
        var mockHomeInteractor: MockDefaultListFruitInteractor!
        var mockHomeViewController: MockHomeViewController!
        var error: Error!

        describe("Test LoginPresenter") {

            context("Test LoginPresenter's functions") {

                beforeEach {
                    mockHomeViewController = MockHomeViewController()
                    mockHomeRouter = MockDefaultHomeRouter()
                    mockHomeInteractor = MockDefaultListFruitInteractor()
                    homePresenter = DefaultHomePresenter(view: mockHomeViewController, router: mockHomeRouter, fruitInteractor: mockHomeInteractor)
                    error = Dummy.error
                }

                it("Test error should was sent to class implement it") {
                    homePresenter.showError(error: error)
                    expect(mockHomeRouter.error?._domain) == "trongque"
                }

                it("Test func updateView() is called") {
                    homePresenter.updateView(fruits: Dummy.fruits)
                    expect(mockHomeViewController.fruits.count) == 1
                    expect(mockHomeViewController.fruits[0].name) == "Banana"
                    expect(mockHomeViewController.fruits[0].price) == 10.5
                }

                it("Test func viewDidLoad() was send to class implement it") {
                    homePresenter.viewDidLoad()
                    expect(mockHomeInteractor.check) == true
                }
            }
        }
    }
}

extension HomePresenterTests {

    struct Dummy {
        static let error = NSError(domain: "trongque", code: 404, userInfo: nil)

        static let fruits: [Fruit] = {
            let fruit = Fruit(entity: FruitEntity(name: "Banana", price: 10.5))
            return [fruit]
        }()
    }
}

