//
//  FoodAPIRepresentation.swift
//  OpenFoods
//
//  Created by Sawyer Vaughan on 24/08/2023.
//

import Foundation

/// The representation of a food item retrieved from the API.
///
/// The properties of this struct match the key and type of the JSON returned from the API in order
/// to take advantage of the Codable infrastructure to parse the JSON.
struct FoodAPIRepresentation: Codable {
  let id: Int
  let name: String
  let isLiked: Bool
  let photoURL: String
  let description: String
  let countryOfOrigin: String
  let lastUpdatedDate: String
  
  func toFood() -> Food? {
    let dateFormatter = ISO8601DateFormatter()
    guard let parsedDate = dateFormatter.date(from: lastUpdatedDate) else {
      // assertionFailure does not crash in prod, but can be useful for developers finding issues.
      assertionFailure("Unable to parse date from API: \(lastUpdatedDate)")
      return nil
    }
    guard let parsedURL = URL(string: photoURL) else {
      assertionFailure("Unable to parse photo URL: \(photoURL)")
      return nil
    }
    return Food(
      id: id,
      name: name,
      isLiked: isLiked,
      photoURL: parsedURL,
      description: description,
      countryOfOrigin: countryOfOrigin,
      lastUpdatedDate: parsedDate
    )
  }
}
