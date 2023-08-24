//
//  FoodListViewRow.swift
//  OpenFoods
//
//  Created by Sawyer Vaughan on 24/08/2023.
//

import Foundation
import SwiftUI

/// The minimum button size. For accessibility reasons, this is the smallest tap area a button
/// should be.
private let minimumButtonSize = 44.0

/// The size of the food image.
private let foodImageSize = 48.0

struct FoodListViewRow: View {
  @EnvironmentObject private var foodRepository: FoodRepository
  
  let item: Food
  
  var body: some View {
    HStack(spacing: 0) {
      VStack(alignment: .leading, spacing: 0) {
        HStack(alignment: .center, spacing: 0) {
          FoodImageView(imageURL: item.photoURL)
            .frame(width: foodImageSize, height: foodImageSize)
            .cornerRadius(8)
            .padding(.trailing, 12)
          
          VStack(alignment: .leading, spacing: 4) {
            Text(item.name)
              .font(.title2)
            
            FoodOriginView(origin: item.countryOfOrigin)
          }
          
          // `minLength: 0` is required because Spacers have a non-zero minimum length if not
          // supplied.
          Spacer(minLength: 0)
        }
        .padding(.bottom, 8)
        
        Text(item.description)
          .font(.subheadline)
          .lineLimit(3)
      }
      
      Spacer(minLength: 8)
      
      Button {
        foodRepository.toggleItemLikeStatus(item: item)
      } label: {
        FoodHeartView(isLiked: item.isLiked)
          // Ensure the button is large enough to meet a11y guidelines. Center align means that the
          // original view will be centered and padding added on the sides if it was not big
          // enough.
          .frame(minWidth: minimumButtonSize, minHeight: minimumButtonSize, alignment: .center)
      }
      // Applying the button style is necessary to make the button take tap precendence over the
      // list row. (I don't know why.)
      // See https://stackoverflow.com/a/59402642.
      .buttonStyle(.borderless)
    }
  }
}

struct FoodListViewRow_Previews: PreviewProvider {
  static var previews: some View {
    FoodListViewRow(item: fakeFood.first!)
      .environmentObject(FoodImageLoader())
  }
}
