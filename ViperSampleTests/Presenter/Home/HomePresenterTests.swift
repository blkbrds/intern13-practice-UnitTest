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
        var defaultHomePresenter: DefaultHomePresenter!
        var mockDefaultHomeRouter: MockDefaultHomeRouter!
        var mockDefaultListFruitInteractor: MockDefaultListFruitInteractor!
        var mockHomeViewController: MockHomeViewController!
        var error: Error!

        describe("Test LoginPresenter") {

            context("Test LoginPresenter's functions") {

                beforeEach {
                    mockHomeViewController = MockHomeViewController()
                    mockDefaultHomeRouter = MockDefaultHomeRouter()
                    mockDefaultListFruitInteractor = MockDefaultListFruitInteractor()
                    defaultHomePresenter = DefaultHomePresenter(view: mockHomeViewController, router: mockDefaultHomeRouter, fruitInteractor: mockDefaultListFruitInteractor)
                    error = Dummy.error
                }

                it("Test error should was sent to class implement it") {
                    defaultHomePresenter.showError(error: error)
                    expect(mockDefaultHomeRouter.error?._domain) == "trongque"
                }

                it("Test func updateView() is called") {
                    defaultHomePresenter.updateView(fruits: Dummy.fruits)
                    expect(mockHomeViewController.fruits.count) == 1
                    expect(mockHomeViewController.fruits[0].name) == "Banana"
                    expect(mockHomeViewController.fruits[0].price) == 10.5
                }

                it("Test func viewDidLoad() was send to class implement it") {
                    defaultHomePresenter.viewDidLoad()
                    expect(mockDefaultListFruitInteractor.check) == true
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

