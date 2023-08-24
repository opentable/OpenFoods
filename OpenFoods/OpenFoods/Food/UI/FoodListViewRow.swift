//
//  FoodListViewRow.swift
//  OpenFoods
//
//  Created by Sawyer Vaughan on 24/08/2023.
//

import Foundation
import SwiftUI

struct FoodListViewRow: View {
  let item: Food
  
  var body: some View {
    VStack(alignment: .leading) {
      Text(item.name)
        .font(.title2)
        .padding(.bottom, 2)
      
      Text(item.description)
        .font(.body)
        .lineLimit(3)
    }
  }
}

struct FoodListViewRow_Previews: PreviewProvider {
  static var previews: some View {
    FoodListViewRow(item: fakeFood.first!)
  }
}
