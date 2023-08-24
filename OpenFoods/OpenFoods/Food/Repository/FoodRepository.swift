//
//  FoodRepository.swift
//  OpenFoods
//
//  Created by Sawyer Vaughan on 24/08/2023.
//

import Foundation

/// The repository holding the current state of food for the app.
///
/// The repository's responsibility is to manage the local app state and not to interact with the
/// API directly. For example, it is responsible for holding the loading/error state, or for
/// updating local items optimistically when modifying data, so that SwiftUI is able to update
/// immediately.
class FoodRepository: ObservableObject {
  /// The set of possible states of the repository.
  enum State {
    /// Food has not been loaded yet.
    case loading
    /// The food has been loaded. The current food is in the associated value.
    case loaded(food: [Food])
    /// There was an error fetching food. The error is contained in the associated value.
    case error(error: Error)
  }
  
  /// The current state of the repository.
  @Published private(set) var state: State = .loading
  
  private let dataSource = FoodAPIDataSource()
  
  /// Loads the food from the API.
  func loadFood() {
    // If in the error state, reset to the loading state. Otherwise, leave it be, and the UI should
    // only update with the differences since last fetch.
    if case .error = state {
      state = .loading
    }
    
    Task {
      do {
        let food = try await dataSource.fetchFood()
        // Published properties must be updated on the main thread.
        await MainActor.run {
          self.state = .loaded(food: food)
        }
      } catch {
        await MainActor.run {
          self.state = .error(error: error)
        }
      }
    }
  }
  
  func toggleItemLikeStatus(item itemToToggle: Food) {
    guard case .loaded(let food) = state else {
      // How did we end up in the state where we were liking an item without having loaded them?
      // Nothing to do here, so we just return, but assert to alert the programmer.
      assertionFailure("Unable to like/unlike food as items were not loaded")
      return
    }
            
    // Optimistically update the item's status locally, so that the UI updates immediately.
    let optimisticallyUpdatedFood = updateFood(food, togglingItemIsLiked: itemToToggle)
    state = .loaded(food: optimisticallyUpdatedFood)
    
    Task {
      do {
        try await dataSource.toggleItemLikeStatus(item: itemToToggle)
      } catch {
        // TODO: Notify user with a toast, etc.
        await MainActor.run {
          // Revert to the original state, as the request failed.
          // TODO: There is a potential race condition here where multiple requests could result
          // in an incorrect final state.
          self.state = .loaded(food: food)
        }
      }
    }
  }
  
  /// Returns the given array of food, with the `itemToToggle`'s `isLiked` property toggled from
  /// true to false or vice-versa.
  private func updateFood(_ food: [Food], togglingItemIsLiked itemToToggle: Food) -> [Food] {
    return food.map { item in
      guard item.id == itemToToggle.id else {
        return item
      }
      return itemToToggle.togglingIsLiked()
    }
  }
}
