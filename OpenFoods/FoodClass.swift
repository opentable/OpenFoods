//
//  FoodClass.swift
//  OpenFoods
//
//  Created by Gabriella Aguilar on 17/08/2023.
//  Copyright © 2023 OpenTable, Inc. All rights reserved.
//

import Foundation

public struct Food: Decodable {
    let id: Int
    let name: String
    let isLiked: Bool
    let photoURL: URL?
    let description: String
    let countryOfOrigin: String
    let lastUpdatedDate: Date
}
