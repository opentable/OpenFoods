//
//  FoodListResponse.swift
//  OpenFoods
//
//  Created by Brian Munjoma on 01/09/2023.
//  Copyright © 2023 OpenTable, Inc. All rights reserved.
//

import Foundation

struct FoodListItem: Decodable {
    let id : Int
    let name : String
    let isLiked : Bool
    let photoURL : String
    let description : String
    let countryOfOrigin : String
    let lastUpdatedDate : Date
}
