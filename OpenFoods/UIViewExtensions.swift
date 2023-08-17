//
//  UIViewExtensions.swift
//  OpenFoods
//
//  Created by Gabriella Aguilar on 17/08/2023.
//  Copyright © 2023 OpenTable, Inc. All rights reserved.
//

import UIKit


extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get { self.layer.cornerRadius }
        set { self.layer.cornerRadius = newValue }
    }
}
