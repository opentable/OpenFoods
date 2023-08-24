//
//  View+MinimumButtonSize.swift
//  OpenFoods
//
//  Created by Sawyer Vaughan on 24/08/2023.
//

import Foundation
import SwiftUI

/// The minimum button size. For accessibility reasons, this is the smallest tap area a button
/// should be.
private let minimumButtonSize = 44.0

extension View {
  /// Returns a view with the minimum size required of tappable buttons to meet accessibility
  /// requirements.
  func applyMinimumButtonSize() -> some View {
    // Center align means that the original view will be centered and padding added on the sides if
    // it was not big enough.
    frame(minWidth: minimumButtonSize, minHeight: minimumButtonSize, alignment: .center)
  }
}
