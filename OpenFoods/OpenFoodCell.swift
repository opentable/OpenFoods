//
//  OpenFoodCell.swift
//  OpenFoods
//
//  Created by Gabriella Aguilar on 17/08/2023.
//  Copyright © 2023 OpenTable, Inc. All rights reserved.
//

import UIKit

public class OpenFoodCell: UICollectionViewCell {
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
        nameLabel?.text = food.name
    }
}
