//
//  AlertManager.swift
//  OpenFoods
//
//  Created by Sawyer Vaughan on 24/08/2023.
//

import Foundation

/// The object that manages the presentation of alerts to the user.
///
/// This class simply holds the state of the presented alert, and RootView wires this together with
/// the UI, so that an alert is presented when `alertText` is set.
class AlertManager: ObservableObject {
  /// Whether an alert should be presented.
  var isPresented: Bool {
    get {
      alertText != nil
    }
    set {
      assert(newValue == false, "Expected isPresented to only be set to false by SwiftUI!")
      alertText = nil
    }
  }
  
  @Published private(set) var alertText: String? = nil
  
  /// Presents the user with a dismissable alert showing the given text.
  func presentAlert(text: String) {
    alertText = text
  }
}
