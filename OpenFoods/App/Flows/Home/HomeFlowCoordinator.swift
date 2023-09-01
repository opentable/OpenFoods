//
//  HomeFlowCoordinator.swift
//  OpenFoods
//
//  Created by Brian Munjoma on 01/09/2023.
//  Copyright © 2023 OpenTable, Inc. All rights reserved.
//

import Foundation
import UIKit

final class HomeFlowCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator]
    let navigationController: UINavigationController
    
    init(childCoordinators: [Coordinator] = [], navigationController: UINavigationController) {
        self.childCoordinators = childCoordinators
        self.navigationController = navigationController
    }
    
    func start() {
        let view = HomeTableViewController.instantiate()
        
        // create viewModel
        
        navigationController.setViewControllers([view], animated: false)
    }
    
    
}
