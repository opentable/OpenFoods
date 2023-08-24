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
    ScrollView(.vertical) {
      VStack(alignment: .leading, spacing: 4) {
        FoodImageView(imageURL: item.photoURL)
          // Set the frame to an appropriate height. Unfortunately, the size of the image is not
          // known before finishing the fetch. Therefore, using a fixed height prevents the UI from
          // jumping around when the fetch completes.
          .frame(height: 256)
          .cornerRadius(12)
          .padding(.bottom, 12)
        
        FoodOriginView(origin: item.countryOfOrigin)
        
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
      .environmentObject(FoodImageLoader())
  }
}
