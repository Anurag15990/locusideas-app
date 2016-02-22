//
//  ProfileInfoCard.swift
//  client
//
//  Created by Neha Yadav on 22/02/16.
//  Copyright © 2016 LocusIdeas. All rights reserved.
//

import UIKit

class DesignerProfileInfoCard : UITableViewCell {
    
    @IBOutlet weak var coverImageView : UIImageView!
    @IBOutlet weak var profileImageView : UIImageView!
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var currentDesignationLabel : UILabel!
    @IBOutlet weak var locationLabel : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpInitialView()
    }
    
    
    func setUpInitialView() {
        
        profileImageView.layer.cornerRadius = 5.0
        profileImageView.layer.borderWidth = 2
        profileImageView.layer.borderColor = UIColor.whiteColor().CGColor
        profileImageView.clipsToBounds = true
        
        coverImageView.clipsToBounds = true
        
        coverImageView.image = UIImage(named: "Armchair.png")
        profileImageView.image = UIImage(named: "Nick_Bateman.jpg")
        nameLabel.text = "Dipankar Rajiblochan Chatterjee"
        currentDesignationLabel.text = "Interior Designer @ Locus Ideas"
        locationLabel.text = "Mumbai, Maharashtra, India"
        
    }
}
