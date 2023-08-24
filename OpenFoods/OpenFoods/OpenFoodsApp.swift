//
//  OpenFoodsApp.swift
//  OpenFoods
//
//  Created by Sawyer Vaughan on 24/08/2023.
//

import SwiftUI

@main
struct OpenFoodsApp: App {
  // The OpenTable API data source.
  //
  // TODO: Only temporarily here to test the code.
  private let dataSource = FoodAPIDataSource()
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .task {
          let food = try? await dataSource.fetchFood()
          print("Fetched food: \(food)")
        }
    }
  }
}
