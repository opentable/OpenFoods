//
//  FoodAPILikeResponse.swift
//  OpenFoods
//
//  Created by Sawyer Vaughan on 24/08/2023.
//

import Foundation

/// The response from the server for a like or unlike request.
///
/// The properties of this struct match the key and type of the JSON returned from the API in order
/// to take advantage of the Codable infrastructure to parse the JSON.
struct FoodAPILikeResponse: Codable {
  let success: Bool
}
