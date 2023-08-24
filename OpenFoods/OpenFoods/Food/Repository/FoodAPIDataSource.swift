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
      let apiRepresentations = try jsonDecoder.decode([FoodAPIRepresentation].self, from: data)
      return apiRepresentations.compactMap { $0.toFood() }
    } catch {
      // TODO: Parse the error and return an appropriate code.
      throw FoodAPIError.unknown
    }
  }
  
  // Toggles whether an item is liked or unliked.
  func toggleItemLikeStatus(item: Food) async throws {
    let urlFinalPath = item.isLiked ? "unlike" : "like"
    let url = baseAPIURL.appending(path: "\(item.id)/\(urlFinalPath)")
    let session = URLSession(configuration: .default)
    var request = URLRequest(url: url)
    request.httpMethod = "PUT"
    do {
      let (data, _) = try await session.data(for: request)
      let jsonDecoder = JSONDecoder()
      // When the like fails, the backend returns {"error": "message"}. This will fail decoding
      // to the like response. This is good enough for our purposes right now, but parsing the
      // error message would be better.
      let response = try jsonDecoder.decode(FoodAPILikeResponse.self, from: data)
      if !response.success {
        // TODO: This will be caught and re-thrown - I should re-architect this to avoid that
        // awkwardness.
        throw FoodAPIError.unknown
      }
    } catch {
      throw FoodAPIError.unknown
    }
  }
}
