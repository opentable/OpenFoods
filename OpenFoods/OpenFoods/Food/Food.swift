//
//  Food.swift
//  OpenFoods
//
//  Created by Sawyer Vaughan on 24/08/2023.
//

import Foundation

/// The model representing of a food.
///
/// This model is distinct from the API representation, and is the definitive model used throughout
/// the app.
struct Food {
  let id: Int
  let name: String
  let isLiked: Bool
  let photoURL: URL
  let description: String
  let countryOfOrigin: String
  let lastUpdatedDate: Date
}
