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
    @IBOutlet weak var followButton : UIButton!
    @IBOutlet weak var followersCount : UILabel!
    @IBOutlet weak var followingCount : UILabel!
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var currentDesignationLabel : UILabel!
    @IBOutlet weak var locationLabel : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpInitialView()
        self.selectionStyle = .None
    }
    
    
    func setUpInitialView() {
        
        profileImageView.layer.cornerRadius = 5.0
        profileImageView.layer.borderWidth = 2
        profileImageView.layer.borderColor = UIColor.whiteColor().colorWithAlphaComponent(0.60).CGColor
        profileImageView.clipsToBounds = true
        
        coverImageView.clipsToBounds = true
        coverImageView.image = UIImage(named: "Armchair.png")
        
        followButton.layer.cornerRadius = CGFloat(5)
        followButton.layer.borderWidth = 2
        followButton.layer.borderColor = UIColor(red: 4.0/255.0, green: 158.0/255.0, blue: 143.0/255.0, alpha: 1.0).CGColor
        
        let followIcon = ""
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.0
        let followText = followIcon + " FOLLOW"
        let followString = NSMutableAttributedString(string: followText, attributes: [NSFontAttributeName: UIFont(name: "Montserrat-SemiBold", size: 12.0)!])
        followString.addAttribute(NSFontAttributeName, value: UIFont(name: "MaterialDesignIcons", size: 16.0)!, range: NSRange(location: 0, length: 1))
        followString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSRange(location: 0, length: followString.length))
        followString.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 4.0/255.0, green: 158.0/255.0, blue: 143.0/255.0, alpha: 1.0), range: NSRange(location: 0, length: followString.length))
        followButton.backgroundColor = UIColor.whiteColor()
        followButton.setAttributedTitle(followString, forState: .Normal)
        
        
        followersCount.text = "12345"
        followingCount.text = "123456"
        profileImageView.image = UIImage(named: "Nick_Bateman.jpg")
        nameLabel.text = "Dipankar Rajiblochan Chatterjee"
        currentDesignationLabel.text = "Interior Designer @ Locus Ideas"
        
        let locationIcon = ""
        let locationParagraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.0
        let locationLabelText = locationIcon + " Mumbai, Maharashta, India"
        let myMutableString = NSMutableAttributedString(string: locationLabelText, attributes: [NSFontAttributeName: UIFont(name: "Montserrat-Regular", size: 12.0)!])
        myMutableString.addAttribute(NSFontAttributeName, value: UIFont(name: "MaterialDesignIcons", size: 16.0)!, range: NSRange(location: 0, length: 1))
        myMutableString.addAttribute(NSParagraphStyleAttributeName, value: locationParagraphStyle, range: NSRange(location: 0, length: myMutableString.length))
        locationLabel.attributedText = myMutableString
        locationLabel.textAlignment = .Center
    }
    
    var followFlag = false
    
    @IBAction func followButton(sender: UIButton) {
        
        followFlag = !followFlag
        
        if followFlag {
            
            let followingIcon = ""
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineHeightMultiple = 1.0
            let followingText = followingIcon + " FOLLOWING"
            let followingString = NSMutableAttributedString(string: followingText, attributes: [NSFontAttributeName: UIFont(name: "Montserrat-SemiBold", size: 12.0)!])
            followingString.addAttribute(NSFontAttributeName, value: UIFont(name: "MaterialDesignIcons", size: 16.0)!, range: NSRange(location: 0, length: 1))
            followingString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSRange(location: 0, length: followingString.length))
            followingString.addAttribute(NSForegroundColorAttributeName, value: UIColor.whiteColor(), range: NSRange(location: 0, length: followingString.length))
            sender.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            sender.backgroundColor = UIColor(red: 4.0/255.0, green: 158.0/255.0, blue: 143.0/255.0, alpha: 1.0)
            sender.setAttributedTitle(followingString, forState: .Normal)
            
        } else {
            
            let followIcon = ""
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineHeightMultiple = 1.0
            let followText = followIcon + " FOLLOW"
            let followString = NSMutableAttributedString(string: followText, attributes: [NSFontAttributeName: UIFont(name: "Montserrat-SemiBold", size: 12.0)!])
            followString.addAttribute(NSFontAttributeName, value: UIFont(name: "MaterialDesignIcons", size: 16.0)!, range: NSRange(location: 0, length: 1))
            followString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSRange(location: 0, length: followString.length))
            followString.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 4.0/255.0, green: 158.0/255.0, blue: 143.0/255.0, alpha: 1.0), range: NSRange(location: 0, length: followString.length))
            sender.setTitleColor(UIColor(red: 4.0/255.0, green: 158.0/255.0, blue: 143.0/255.0, alpha: 1.0), forState: .Normal)
            sender.backgroundColor = UIColor.whiteColor()
            sender.setAttributedTitle(followString, forState: .Normal)
        }
    }
}
