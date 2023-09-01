//
//  HomeViewModelTests.swift
//  AppTests
//
//  Created by Brian Munjoma on 01/09/2023.
//  Copyright © 2023 OpenTable, Inc. All rights reserved.
//

import XCTest
@testable import OpenFoods

final class HomeViewModelTests: XCTestCase {

    var sut: HomeFlowViewModel!
    
    override func setUp() {
        InjectedValues[\.clientProvider] = MockClient<Int>()
        
        sut = HomeFlowViewModel()
    }
    
    override func tearDown() {
        sut = nil
    }

    // MARK: - Initial State
    func test_EmptyViewModel_ZeroSections() {
        let result = sut.numberOfSections
        XCTAssertEqual(result, 0)
    }

    func test_EmptyViewModel_ZeroItemsInSectionZero() {
        let result = sut.numberOfItems(in: 0)
        XCTAssertEqual(result, 0)
    }

    func test_EmptyViewModel_NoItems() {
        let zero = IndexPath(row: 0, section: 0)
        let result = sut.item(at: zero)
        XCTAssertNil(result)
    }

    func test_EmptyViewModel_ZeroItemsInNegativeSection() {
        let result = sut.numberOfItems(in: -1)
        XCTAssertEqual(result, 0)
    }

    func test_EmptyViewModel_NoItemAtNegativeSection() {
        let negative = IndexPath(row: 0, section: -1)
        let result = sut.item(at: negative)
        XCTAssertNil(result)
    }

    func test_EmptyViewModel_NoItemAtNegativeRow() {
        let negative = IndexPath(row: -1, section: 0)
        let result = sut.item(at: negative)
        XCTAssertNil(result)
    }
    
    // MARK: - Three Items
    func test_ThreeModels_HasOneSection() {

        let models = 3.mockFoodItems
        sut = HomeFlowViewModel(foodItems: models)
        let result = sut.numberOfSections

        XCTAssertEqual(result, 1)
    }

    func test_ThreeModels_OneItemInSectionZero() {

        let models = 3.mockFoodItems
        sut = HomeFlowViewModel(foodItems: models)
        let result = sut.numberOfItems(in: 0)

        XCTAssertEqual(result, 3)
    }

    func test_ThreeModels_ZeroItemsInSectionOne() {

        let models = 3.mockFoodItems
        sut = HomeFlowViewModel(foodItems: models)
        let result = sut.numberOfItems(in: 1)

        XCTAssertEqual(result, 0)
    }

    func test_ThreeModels_HasItemAtIndexPathZero() {

        let models = 3.mockFoodItems
        sut = HomeFlowViewModel(foodItems: models)
        let zero = IndexPath(row: 0, section: 0)
        let result = sut.item(at: zero)

        XCTAssertNotNil(result)
    }

    func test_ThreeModels_ZeroItemsInNegativeSection() {

        let models = 3.mockFoodItems
        sut = HomeFlowViewModel(foodItems: models)
        let result = sut.numberOfItems(in: -1)

        XCTAssertEqual(result, 0)
    }

    func test_ThreeModels_NoItemAtNegativeSection() {

        let models = 3.mockFoodItems
        sut = HomeFlowViewModel(foodItems: models)
        let negative = IndexPath(row: 0, section: -1)
        let result = sut.item(at: negative)

        XCTAssertNil(result)
    }

    func test_ThreeModels_NoItemAtNegativeRow() {

        let models = 3.mockFoodItems
        sut = HomeFlowViewModel(foodItems: models)
        let negative = IndexPath(row: -1, section: 0)
        let result = sut.item(at: negative)

        XCTAssertNil(result)
    }
}
