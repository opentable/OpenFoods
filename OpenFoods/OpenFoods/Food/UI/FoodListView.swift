//
//  FoodListView.swift
//  OpenFoods
//
//  Created by Sawyer Vaughan on 24/08/2023.
//

import Foundation
import SwiftUI

struct FoodListView: View {
  let food: [Food]
  
  var body: some View {
    if !food.isEmpty {
      List {
        // Food is Identifiable, so no id needed.
        // This does assume the API will give us unique IDs for each item.
        ForEach(food) { item in
          Text(item.name)
        }
      }
    } else {
      // TODO: Improve error UI.
      Text("No food returned from API!")
    }
  }
}
