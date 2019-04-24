//
//  ListFruitInteractorTests.swift
//  ViperSampleTests
//
//  Created by MBA0010 on 4/19/19.
//  Copyright © 2019 Van Le H. All rights reserved.
//

import Quick
import Nimble

@testable import ViperSample

final class ListFruitInteractorTests: QuickSpec {

    override func spec() {
        
        var defaultLFI: DefaultListFruitInteractor!
        var fruitServiceStub: FruitServicesStub!
        
        beforeEach {
            defaultLFI = DefaultListFruitInteractor()
        }
        
        describe("Test function 'getFruits()' ") {
            
            var mockHomePresenter: MockHomePresenter!
            
            context("When completion success") {
                
                beforeEach {
                    fruitServiceStub = FruitServicesStub(completionFlag: true)
                    defaultLFI.fruitServices = fruitServiceStub
                    
                    mockHomePresenter = MockHomePresenter()
                    defaultLFI.output = mockHomePresenter
                    
                    defaultLFI.getFruits()
                }
                
                it("Number of element 'fruits' array should be 2") {
                    expect(mockHomePresenter.fruits.count) == 2
                }
                
                it("Element of 'fruits' array should be instance of 'Fruit'") {
                    expect(mockHomePresenter.fruits.first).to(beAnInstanceOf(Fruit.self))
                    expect(mockHomePresenter.fruits.last).to(beAnInstanceOf(Fruit.self))
                }
                
                it("Test first element of 'fruits' array") {
                    expect(mockHomePresenter.fruits.first?.name) == "WaterMelon"
                    expect(mockHomePresenter.fruits.first?.price) == 15
                }
                
                afterEach {
                    mockHomePresenter = nil
                    fruitServiceStub = nil
                }
            }
            
            context("When completion failure") {
                
                beforeEach {
                    fruitServiceStub = FruitServicesStub(completionFlag: false)
                    defaultLFI.fruitServices = fruitServiceStub
                    
                    mockHomePresenter = MockHomePresenter()
                    defaultLFI.output = mockHomePresenter
                    
                    defaultLFI.getFruits()
                }
                
                it("Error should be pass to class implement") {
                    expect(mockHomePresenter.error?._code) == 404
                    expect(mockHomePresenter.error?._domain) == "https://404Error"
                }
                
                afterEach {
                    mockHomePresenter = nil
                    fruitServiceStub = nil
                }
            }
            
        }
        
        afterEach {
            defaultLFI = nil
        }
    }
}
