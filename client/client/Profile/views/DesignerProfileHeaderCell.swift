//
//  DesignerProfileHeaderCell.swift
//  client
//
//  Created by Anurag Agnihotri on 17/07/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import UIKit

class DesignerProfileHeaderCell: UITableViewCell {

    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var locationLabelHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var locationLabelTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var followButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.profilePictureImageView.layer.borderColor = UIColor.whiteColor().CGColor
        self.profilePictureImageView.layer.borderWidth = 1.5
        
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
