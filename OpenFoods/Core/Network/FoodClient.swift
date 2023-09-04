//
//  FoodClient.swift
//  OpenFoods
//
//  Created by Brian Munjoma on 01/09/2023.
//  Copyright © 2023 OpenTable, Inc. All rights reserved.
//

import Foundation
import Poppify

final class FoodClient: Client {
    @Inject(\.environmentProvider) var environment: EnvironmentType
    @Inject(\.sessionProvider) var urlSession: URLSessionType
}
