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
  
  func loadFood() {
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
}
