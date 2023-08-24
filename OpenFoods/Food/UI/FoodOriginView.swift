//
//  FoodOriginView.swift
//  OpenFoods
//
//  Created by Sawyer Vaughan on 24/08/2023.
//

import Foundation
import SwiftUI

struct FoodOriginView: View {
  let origin: String
  
  var body: some View {
    Text(origin)
      .font(.subheadline)
      .padding(.horizontal, 8)
      .padding(.vertical, 2)
      .background(Color(uiColor: .systemGray4))
      .cornerRadius(4)
  }
}
