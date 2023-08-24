//
//  Food.swift
//  OpenFoods
//
//  Created by Sawyer Vaughan on 24/08/2023.
//

import Foundation

/// The representation of a food retrieved from the API.
///
/// The properties of this struct match the key and type of the JSON returned from the API in order
/// to take advantage of the Codable infrastructure to parse the JSON.
struct Food: Codable {
  let id: Int
  let name: String
  let isLiked: Bool
  let photoURL: String
  let description: String
  let countryOfOrigin: String
  let lastUpdatedDate: String
}
