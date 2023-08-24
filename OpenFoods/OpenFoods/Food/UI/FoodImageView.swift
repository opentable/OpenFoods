//
//  FoodImage.swift
//  OpenFoods
//
//  Created by Sawyer Vaughan on 24/08/2023.
//

import Foundation
import SwiftUI

/// A view that displays a placeholder, and then loads the given image for the URL and displays it.
struct FoodImageView: View {
  /// The possible states that the image view can be in.
  private enum LoadingState {
    /// The image is loading.
    case loading
    /// The image is loaded.
    case loaded(image: UIImage)
    /// There was an error loading the image.
    case error(error: Error)
  }
  
  let imageURL: URL
  
  @EnvironmentObject private var imageLoader: FoodImageLoader
  
  @State private var state: LoadingState = .loading
  
  var body: some View {
    Group {
      switch state {
      case .loading:
        RoundedRectangle(cornerRadius: 4)
          .fill(Color(uiColor: .systemGray4))
      case .loaded(let image):
        Image(uiImage: image)
          .resizable()
          // Ensure the image keeps its aspect ratio.
          .scaledToFill()
      case .error:
        // TODO: Better communicate error.
        RoundedRectangle(cornerRadius: 4)
          .fill(Color(uiColor: .systemRed))
      }
    }
    .task {
      do {
        let image = try await imageLoader.loadImage(url: imageURL)
        await MainActor.run {
          state = .loaded(image: image)
        }
      } catch {
        await MainActor.run {
          state = .error(error: error)
        }
      }
    }
  }
}
