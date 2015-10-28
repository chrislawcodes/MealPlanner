//
//  ResultCell.swift
//  MealPlanner
//
//  Created by Claw on 10/27/15.
//  Copyright © 2015 Claw. All rights reserved.
//

import UIKit

class ResultCell: UITableViewCell {

    @IBOutlet weak var recipenameLabel: UILabel!
    
    @IBOutlet weak var recipeImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
