//
//  FoodAPIDataSource.swift
//  OpenFoods
//
//  Created by Sawyer Vaughan on 24/08/2023.
//

import Foundation

/// The base URL for the OpenTable food API.
///
/// Note that in Google's style guide, force unwraps were allowed for errors that only occurred due
/// to programmer error. I would be happy to handle this unwrap more safely if desired.
private let baseAPIURL =
  URL(string: "https://opentable-dex-ios-test-d645a49e3287.herokuapp.com/api/v1/svaughan/food")!

/// The data source that fetches the list of food from the OpenTable API.
class FoodAPIDataSource {
  /// The set of possible errors encountered when fetching food from the API.
  enum FoodAPIError: Error {
    /// An unknown error occurred.
    case unknown
  }
  
  /// Fetches the food from the OpenTable API.
  func fetchFood() async throws -> [Food] {
    let session = URLSession(configuration: .default)
    do {
      let (data, _) = try await session.data(from: baseAPIURL)
      let jsonDecoder = JSONDecoder()
      return try jsonDecoder.decode([Food].self, from: data)
    } catch {
      // TODO: Parse the error and return an appropriate code.
      throw FoodAPIError.unknown
    }
  }
}
