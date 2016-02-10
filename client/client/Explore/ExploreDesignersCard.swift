//
//  ExploreDesignersCard.swift
//  client
//
//  Created by Neha Yadav on 07/02/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import UIKit

class ExploreDesignersCard: UITableViewCell {
    
    @IBOutlet weak var containerView : ContainerView!
    @IBOutlet weak var designerProfileImage : UIImageView!
    @IBOutlet weak var designerNameLabel : UILabel!
    @IBOutlet weak var categoryLabel : UILabel!
    @IBOutlet weak var followButton : UIButton!
    @IBOutlet weak var designCarouselView : UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        designerProfileImage.image = UIImage(named: "Nick_Bateman.jpg")
        designerNameLabel.text = "Dipankar Rajiblochan Chatterjee"
        categoryLabel.text = "Interior Design, Office Design, Furniture Design"
        
        followButton.layer.borderColor = UIColor(red: 4.0/255.0, green: 158.0/255.0, blue: 143.0/255.0, alpha: 1.0).CGColor
        followButton.layer.borderWidth = 2
        followButton.layer.cornerRadius = CGFloat(5)
        
        designCarouselView.image = UIImage(named: "Armchair.png")
        designCarouselView.clipsToBounds = true
        
        self.selectionStyle = .None
        
    }
    
    @IBAction func followButton(sender: UIButton) {
        
        if sender.currentTitleColor != UIColor.whiteColor() {
            sender.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            sender.backgroundColor = UIColor(red: 4.0/255.0, green: 158.0/255.0, blue: 143.0/255.0, alpha: 1.0)
            sender.setAttributedTitle(NSAttributedString(string: "", attributes: [NSFontAttributeName:UIFont(name: "MaterialDesignIcons", size: 22.0)!, NSForegroundColorAttributeName: UIColor.whiteColor()]), forState: UIControlState.Normal)
        } else {
            sender.setTitleColor(UIColor(red: 4.0/255.0, green: 158.0/255.0, blue: 143.0/255.0, alpha: 1.0), forState: .Normal)
            sender.backgroundColor = UIColor.whiteColor()
            sender.setAttributedTitle(NSAttributedString(string: "", attributes: [NSFontAttributeName: UIFont(name: "MaterialDesignIcons", size: 22.0)!, NSForegroundColorAttributeName: UIColor(red: 4.0/255.0, green: 158.0/255.0, blue: 143.0/255.0, alpha: 1.0)]), forState: UIControlState.Normal)
        }
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
