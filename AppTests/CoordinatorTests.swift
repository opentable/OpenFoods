//
//  CoordinatorTests.swift
//  AppTests
//
//  Created by Brian Munjoma on 01/09/2023.
//  Copyright © 2023 OpenTable, Inc. All rights reserved.
//

import XCTest
@testable import OpenFoods

final class CoordinatorTests: XCTestCase {
    
    // MARK: - Main Coordinator Tests
    func test_InitialAppCoordinator_HasNoChildren() {
        
        // Given
        let sut = AppCoordinator(UIWindow())
        
        // When
        let result = sut.childCoordinators.count
        
        // Then
        XCTAssertEqual(result, 0)
    }
    
    func test_AppCoordinatorOnStart_HasOneChild() {
        
        // Given
        let sut = AppCoordinator(UIWindow())
        sut.start()
        
        // When
        let result = sut.childCoordinators.count
        
        // Then
        XCTAssertEqual(result, 1)
    }
    
    // MARK: - Home Coordinator Tests
    func test_InitialHomeFlowCoordinator_HasNoChildren() {
        
        // Given
        let sut = HomeFlowCoordinator(childCoordinators: [], navigationController: UINavigationController())
        
        // When
        let result = sut.childCoordinators.count
        
        // Then
        XCTAssertEqual(result, 0)
    }
    
    func test_HomeFlowCoordinatorOnStart_HasNoChildren() {
        
        // Given
        let sut = HomeFlowCoordinator(childCoordinators: [], navigationController: UINavigationController())
        sut.start()
        
        // When
        let result = sut.childCoordinators.count
        
        // Then
        XCTAssertEqual(result, 0)
    }
    
}
