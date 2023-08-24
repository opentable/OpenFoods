//
//  OpenFoodsApp.swift
//  OpenFoods
//
//  Created by Sawyer Vaughan on 24/08/2023.
//

import SwiftUI

@main
struct OpenFoodsApp: App {
  /// The repository containing the current state of loaded food.
  private let foodRepository: FoodRepository
  
  /// The object responsible for loading the images of the items.
  private let imageLoader = FoodImageLoader()
  
  /// The service that handles showing alerts in the app.
  private let alertManager = AlertManager()
  
  init() {
    foodRepository = FoodRepository(alertManager: alertManager)
  }
  
  var body: some Scene {
    WindowGroup {
      RootView()
        // Pass services to the RootView and all subviews via the environment. This could be done
        // via initializers instead, but I chose this for the sake of brevity.
        .environmentObject(foodRepository)
        .environmentObject(imageLoader)
        .environmentObject(alertManager)
    }
  }
}
