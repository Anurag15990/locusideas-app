//
//  StreamDesignCard.swift
//  client
//
//  Created by Neha Yadav on 20/01/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import UIKit
import SDWebImage

class StreamDesignCard: UITableViewCell {
    
    @IBOutlet weak var containerView : ContainerView!
    @IBOutlet weak var designCoverImage : UIImageView!
    @IBOutlet weak var designTitleLabel : UILabel!
    @IBOutlet weak var designerNameLabel : UILabel!
    @IBOutlet weak var categoryLabel : UILabel!
    @IBOutlet weak var viewCountLabel : UILabel!
    @IBOutlet weak var appreciationCountLabel : UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        designCoverImage.image = UIImage(named: "Blue_chair.jpg")
        designTitleLabel.text = "Single seater chair in Phantom blue colour with an ottoman".uppercaseString
        designerNameLabel.text = "John Doe"
        categoryLabel.text = "Modern"
        appreciationCountLabel.text = "12345"
        viewCountLabel.text = "123456"
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
