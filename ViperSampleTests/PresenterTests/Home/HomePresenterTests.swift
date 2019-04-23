//
//  HomePresenterTests.swift
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

final class HomePresenterTests: QuickSpec {
    
    override func spec() {
        
        var defaultHomePresenter: DefaultHomePresenter!
        var mockDefaultHomeRouter: MockDefaultHomeRouter!
        var mockHomeViewController: MockHomeViewController!
        var mockDefaultListFruitInteractor: MockDefaultListFruitInteractor!
        
        describe("Test protocol 'HomeView'") {
            
            beforeEach {
                mockDefaultHomeRouter = MockDefaultHomeRouter()
                mockHomeViewController = MockHomeViewController()
                mockDefaultListFruitInteractor = MockDefaultListFruitInteractor()
                defaultHomePresenter = DefaultHomePresenter(view: mockHomeViewController, router: mockDefaultHomeRouter, fruitInteractor: mockDefaultListFruitInteractor)
            }
            
            context("When HomeView is implemented") {
                
                it("Should be return back for HomeViewController") {
                    defaultHomePresenter.updateView(fruits: Dummy.fruits)
                    expect(mockHomeViewController.fruits.count) == 2
                    expect(mockHomeViewController.fruits[0].name) == "Banana"
                    expect(mockHomeViewController.fruits[1].price) == 42.25
                }
                
                it("Should be show error on screen") {
                    defaultHomePresenter.showError(error: Dummy.error)
                    expect(mockDefaultHomeRouter.error?.localizedDescription) == "Value is invalid. Hahahaha"
                }
                
                it("Should be check valus is passed yet?") {
                    defaultHomePresenter.viewDidLoad()
                    expect(mockDefaultListFruitInteractor.isPassValue) == true
                }
            }
            
            afterEach {
                defaultHomePresenter = nil
            }
        }
    }
}

extension HomePresenterTests {
    
    struct Dummy {
        
        static let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Value is invalid. Hahahaha"])
        
        static let fruits: [Fruit] = {
            let banana = Fruit(entity: FruitEntity(name: "Banana", price: 35.0))
            let strawbery = Fruit(entity: FruitEntity(name: "Strawbery", price: 42.25))
            return [banana, strawbery]
        }()
    }
}
