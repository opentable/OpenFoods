//
//  FoodDetailView.swift
//  OpenFoods
//
//  Created by Sawyer Vaughan on 24/08/2023.
//

import SwiftUI

struct FoodDetailView: View {
  let item: Food
  
  var body: some View {
    ScrollView {
      VStack {
        Text(item.description)
          .font(.body)
      }
      .padding()
    }
    .navigationTitle(item.name)
  }
}

struct FoodDetailView_Previews: PreviewProvider {
  static var previews: some View {
    FoodDetailView(item: fakeFood.first!)
  }
}
