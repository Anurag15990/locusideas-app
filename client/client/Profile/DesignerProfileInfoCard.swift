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
    @IBOutlet weak var followersCount : UILabel!
    @IBOutlet weak var followingCount : UILabel!
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
        
        followersCount.text = "12345"
        followingCount.text = "123456"
        profileImageView.image = UIImage(named: "Nick_Bateman.jpg")
        nameLabel.text = "Dipankar Rajiblochan Chatterjee"
        currentDesignationLabel.text = "Interior Designer @ Locus Ideas"
        
        let locationIcon = ""
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.0
        let locationLabelText = locationIcon + " Mumbai, Maharashta, India"
        let myMutableString = NSMutableAttributedString(string: locationLabelText, attributes: [NSFontAttributeName: UIFont(name: "Montserrat-Regular", size: 13.0)!])
        myMutableString.addAttribute(NSFontAttributeName, value: UIFont(name: "MaterialDesignIcons", size: 15.0)!, range: NSRange(location: 0, length: 1))
        myMutableString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSRange(location: 0, length: myMutableString.length))
        locationLabel.attributedText = myMutableString
        locationLabel.textAlignment = .Center
        
    }
}
