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

struct FoodListViewRow: View {
  let item: Food
  
  var body: some View {
    HStack(spacing: 0) {
      VStack(alignment: .leading, spacing: 0) {
        Text(item.name)
          .font(.title2)
          .padding(.bottom, 4)
        
        Text(item.description)
          .font(.subheadline)
          .lineLimit(3)
      }
      
      Spacer(minLength: 8)
      
      Button {
        // TODO: Implement like.
        print("Liked: \(item.name)")
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
  }
}
