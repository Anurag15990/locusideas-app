//
//  DesignerSkillsCollectionViewCell.swift
//  client
//
//  Created by Anurag Agnihotri on 27/07/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import UIKit

class DesignerSkillsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var skillsTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        skillsTitleLabel.layer.borderColor = UIColor.lightGrayColor().CGColor
        skillsTitleLabel.layer.borderWidth = 0.5
        skillsTitleLabel.layer.shadowColor = UIColor(red: 150.0/255.0, green: 150.0/255.0, blue: 150.0/255.0, alpha: 1.0).CGColor
        skillsTitleLabel.layer.shadowOffset = CGSizeMake(0, 0)
        skillsTitleLabel.layer.shadowOpacity = 1.0
        skillsTitleLabel.layer.shadowRadius = 2.0
        // Initialization code
    }

}
