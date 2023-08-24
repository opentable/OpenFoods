//
//  AlertManager.swift
//  OpenFoods
//
//  Created by Sawyer Vaughan on 24/08/2023.
//

import Foundation

class AlertManager: ObservableObject {
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
  
  func presentAlert(text: String) {
    alertText = text
  }
}
