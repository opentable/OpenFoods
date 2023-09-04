//
//  FoodImageLoader.swift
//  OpenFoods
//
//  Created by Sawyer Vaughan on 24/08/2023.
//

import Foundation
import UIKit

/// Responsible for loading images of the food.
///
/// Conforms to ObservableObject so that it may be passed to subviews via the `.environmentObject`
/// mechanism. This is useful so that there is one instance, so that we can avoid loading multiple
/// of the same image.
///
/// TODO: Improve by de-duplicating requests for the same image.
class FoodImageLoader: ObservableObject {
  /// The possible errors that can occur when loading an image.
  enum LoadingError: Error {
    /// An unknown error occurred.
    case unknown
  }
  
  /// Loads the image at the given URL.
  func loadImage(url: URL) async throws -> UIImage {
    let session = URLSession(configuration: .default)
    do {
      let (data, _) = try await session.data(from: url)
      guard let image = UIImage(data: data) else {
        // TODO: This will be caught and re-thrown. Improve this.
        throw LoadingError.unknown
      }
      return image
    } catch {
      throw LoadingError.unknown
    }
  }
}
