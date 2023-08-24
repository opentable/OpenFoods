//
//  OpenFoodsApp.swift
//  OpenFoods
//
//  Created by Sawyer Vaughan on 24/08/2023.
//

import SwiftUI

@main
struct OpenFoodsApp: App {
  // The repository containing the current state of loaded food.
  private let foodRepository = FoodRepository()
  
  var body: some Scene {
    WindowGroup {
      RootView()
        // Pass food repository to the ContentView and all subviews via the environment. This could
        // be done via initializers instead, but I chose this for the sake of brevity.
        .environmentObject(foodRepository)
    }
  }
}
