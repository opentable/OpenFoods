//
//  ContentView.swift
//  OpenFoods
//
//  Created by Sawyer Vaughan on 24/08/2023.
//

import SwiftUI

struct RootView: View {
  @EnvironmentObject private var foodRepository: FoodRepository
  
  var body: some View {
    Group {
      switch foodRepository.state {
      case .loading:
        ProgressView()
      case .loaded(let food):
        NavigationStack {
          FoodListView(food: food)
            .navigationTitle("Food")
            .navigationDestination(for: Food.self) { item in
              // In order for the detail view to get the most recent item updates, find the item in
              // the repository rather than passing on the destination object itself. If the item
              // is unable to be found, fall back to the navigation item. This should not happen,
              // but in general I avoid getting the user into any crashing or weird scenario as
              // much as possible.
              let detailItem = food.first { $0.id == item.id } ?? item
              FoodDetailView(item: detailItem)
            }
        }
      case .error(_):
        // TODO: Handle retry.
        Text("Error loading food!")
      }
    }
    // Task is performed once when the view is displayed. This is preferred over the .onAppear
    // method because it can handle task cancellation on disappear, or even performing a new task
    // if the `task(id:)` method is used.
    .task {
      // Load the food when the view appears. When loaded, the view will update because it is
      // observing the foodRepository in the environment.
      foodRepository.loadFood()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    RootView()
  }
}
