//
//  FoodHeartView.swift
//  OpenFoods
//
//  Created by Sawyer Vaughan on 24/08/2023.
//

import Foundation
import SwiftUI

private let imageSize = 24.0

struct FoodHeartView: View {
  let isLiked: Bool
  
  var body: some View {
    if isLiked {
      imageView(systemName: "heart.fill", uiColor: .systemRed)
    } else {
      imageView(systemName: "heart", uiColor: .systemGray)
    }
  }
  
  @ViewBuilder
  private func imageView(systemName: String, uiColor: UIColor) -> some View {
    Image(systemName: systemName)
      .resizable()
      .scaledToFit()
      .frame(width: imageSize, height: imageSize)
      .foregroundColor(Color(uiColor: uiColor))
  }
}
