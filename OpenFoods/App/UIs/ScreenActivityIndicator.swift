//
//  ScreenActivityIndicator.swift
//  OpenFoods
//
//  Created by Brian Munjoma on 01/09/2023.
//  Copyright © 2023 OpenTable, Inc. All rights reserved.
//

import UIKit

class ScreenActivityIndicator: UIView {

    var blurEffectView: UIVisualEffectView?

    override init(frame: CGRect) {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = frame
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.blurEffectView = blurEffectView
        super.init(frame: frame)
        addSubview(blurEffectView)
        addLoader()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addLoader() {
        guard let blurEffectView = blurEffectView else { return }
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        blurEffectView.contentView.addSubview(activityIndicator)
        activityIndicator.center = blurEffectView.contentView.center
        activityIndicator.startAnimating()
    }
}

extension UIView {
    func showBlurLoader() {
        let activityIndicator = ScreenActivityIndicator(frame: frame)
        self.addSubview(activityIndicator)
    }

    func removeBluerLoader() {
        if let activityIndicator = subviews.first(where: { $0 is ScreenActivityIndicator }) {
            activityIndicator.removeFromSuperview()
        }
    }
}
