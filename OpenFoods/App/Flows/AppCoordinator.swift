//
//  AppCoordinator.swift
//  OpenFoods
//
//  Created by Brian Munjoma on 01/09/2023.
//  Copyright © 2023 OpenTable, Inc. All rights reserved.
//

import Foundation
import UIKit

final class AppCoordinator: Coordinator {
    
    let window: UIWindow
    var childCoordinators: [Coordinator]
    
    init(_ window: UIWindow, childCoordinators: [Coordinator] = []) {
        self.childCoordinators = childCoordinators
        self.window = window
    }
    
    func start() {
        
        let homeNavigationController = UINavigationController()
        
        homeNavigationController.navigationBar.prefersLargeTitles = true
        
        let homeFlowCoordinator = HomeFlowCoordinator(navigationController: homeNavigationController)
        
        homeFlowCoordinator.start()
        
        store(homeFlowCoordinator)
        
        window.rootViewController = homeNavigationController
        window.makeKeyAndVisible()
    }
    
    deinit {
        childCoordinators.forEach { free($0) }
    }
}
