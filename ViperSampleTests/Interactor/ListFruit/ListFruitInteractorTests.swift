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
        var fruitServiceStub: SuccessFruitServiceStub!
        
        beforeEach {
            defaultLFI = DefaultListFruitInteractor()
        }
        
        describe("Test function 'getFruits()' ") {
            
            var mockHomePresenter: MockHomePresenter!
            
            context("When completion success") {
                
                beforeEach {
                    fruitServiceStub = SuccessFruitServiceStub()
                    defaultLFI.fruitServices = fruitServiceStub
                    
                    mockHomePresenter = MockHomePresenter()
                    defaultLFI.output = mockHomePresenter
                    
                    defaultLFI.getFruits()
                }
                
                it("Result should be return success") {
                    switch mockHomePresenter.result {
                    case .success(let fruits):
                        expect(fruits.count) == 2
                        expect(fruits[0].name) == "WaterMelon"
                        expect(fruits[0].price) == 15
                    case .failure:
                        fail()
                    }
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
