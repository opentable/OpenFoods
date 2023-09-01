//
//  Coordinator.swift
//  OpenFoods
//
//  Created by Brian Munjoma on 01/09/2023.
//  Copyright © 2023 OpenTable, Inc. All rights reserved.
//

import Foundation

enum Navigate {
    case toDetail
}

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    func start()
    func navigate(_ navigate: Navigate)
}

extension Coordinator {
    func navigate(_ navigate: Navigate) {}
}

extension Coordinator {
    
    func store(_ coordinator: Coordinator) {
        for element in childCoordinators where element === coordinator {
            return
        }
        childCoordinators.append(coordinator)
    }

    func free(_ coordinator: Coordinator) {
        for (index, element) in childCoordinators.enumerated() where element === coordinator {
            childCoordinators.remove(at: index)
            break
        }
    }
}
