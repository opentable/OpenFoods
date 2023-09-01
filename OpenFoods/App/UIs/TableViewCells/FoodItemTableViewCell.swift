//
//  FoodItemTableViewCell.swift
//  OpenFoods
//
//  Created by Brian Munjoma on 01/09/2023.
//  Copyright © 2023 OpenTable, Inc. All rights reserved.
//

import UIKit

class FoodItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var mainDescription: UILabel!
    @IBOutlet weak var isLikedButton: UIButton!
    @IBOutlet weak var dateUpdated: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainImageView.layer.cornerRadius = 10.0
    }

    override func prepareForReuse() {
        mainTitle.text = nil
        mainDescription.text = nil
        dateUpdated.text = nil
    }
    
}
