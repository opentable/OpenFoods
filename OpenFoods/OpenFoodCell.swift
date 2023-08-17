//
//  OpenFoodCell.swift
//  OpenFoods
//
//  Created by Gabriella Aguilar on 17/08/2023.
//  Copyright © 2023 OpenTable, Inc. All rights reserved.
//

import UIKit

public class OpenFoodCell: UICollectionViewCell {
    public var likeTapped: ((Bool) -> Void)?
    
    @IBOutlet weak var backgroundCard: UIView?
    @IBOutlet weak var dateLabel: UILabel?
    @IBOutlet weak var descriptionLabel: UILabel?
    @IBOutlet weak var countryLabel: UILabel?
    @IBOutlet weak var imageView: UIImageView?
    @IBOutlet weak var likeButton: UIButton?
    @IBOutlet weak var nameLabel: UILabel?
    
    private var food: Food?
    
    public func setup(food: Food) {
        self.food = food
        self.nameLabel?.text = food.name
        self.descriptionLabel?.text = food.description
        self.countryLabel?.text = food.countryOfOrigin
        self.likeButton?.setImage(UIImage(systemName: food.isLiked ? "hand.thumbsup.fill" : "hand.thumbsup"), for: .normal)
        self.likeButton?.tintColor = food.isLiked ? UIColor.red : UIColor.gray
        self.imageView?.cornerRadius = (self.imageView?.frame.height ?? 0) / 2
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        self.dateLabel?.text = dateFormatter.string(from: food.lastUpdatedDate)
    }
    
    @IBAction func likeButtonTapped(_ sender: Any) {
        guard let food = self.food else { return }
        self.likeTapped?(!food.isLiked)
    }
    
    public func toggleLike(like: Bool) {
        self.food?.isLiked = like
        let update = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        self.dateLabel?.text = dateFormatter.string(from: update)
        self.food?.lastUpdatedDate = update
        self.likeButton?.setImage(UIImage(systemName: like ? "hand.thumbsup.fill" : "hand.thumbsup"), for: .normal)
        self.likeButton?.tintColor = like ? UIColor.red : UIColor.gray
    }
}
