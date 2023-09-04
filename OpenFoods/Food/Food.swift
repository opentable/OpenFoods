//
//  Food.swift
//  OpenFoods
//
//  Created by Sawyer Vaughan on 24/08/2023.
//

import Foundation

/// The model representing a food item.
///
/// This model is distinct from the API representation, and is the definitive model used throughout
/// the app.
struct Food: Identifiable, Hashable {
  let id: Int
  let name: String
  let isLiked: Bool
  let photoURL: URL
  let description: String
  let countryOfOrigin: String
  let lastUpdatedDate: Date
  
  /// Returns the food item with the `isLiked` property toggled.
  func togglingIsLiked() -> Food {
    return Food(
      id: id,
      name: name,
      isLiked: !isLiked,
      photoURL: photoURL,
      description: description,
      countryOfOrigin: countryOfOrigin,
      lastUpdatedDate: lastUpdatedDate)
  }
}

#if DEBUG
  let fakeFood = [
    Food(
      id: 1,
      name: "Pasta",
      isLiked: true,
      photoURL:
        URL(string: "https://opentable-dex-ios-test-d645a49e3287.herokuapp.com/images/pasta.jpeg")!,
      description: """
      Pasta is a type of food typically made from an unleavened dough of wheat flour mixed with
      water or eggs, and formed into sheets or other shapes, then cooked by boiling or baking. Rice
      flour, or legumes such as beans or lentils, are sometimes used in place of wheat flour to
      yield a different taste and texture, or as a gluten-free alternative. Pasta is a staple food
      of Italian 🇮🇹 cuisine.
      """,
      countryOfOrigin: "IT",
      lastUpdatedDate: Date())
  ]
#endif
